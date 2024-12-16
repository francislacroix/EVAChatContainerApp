# Reference the existing container app environment
data "azurerm_container_app_environment" "container_app_environment" {
    name                 = var.ContainerAppEnvironmentName
    resource_group_name  = var.InfrastructureResourceGroupName
}

data "azurerm_container_registry" "containerregistry" {
    name                = split(".", var.ContainerRegistryServer)[0]
    resource_group_name = var.InfrastructureResourceGroupName
}

data "azurerm_user_assigned_identity" "appidentity" {
  name                = var.AppIdentityName
  resource_group_name = var.InfrastructureResourceGroupName
}

resource "azurerm_container_app" "containerapp" {
  # Container app general configuration
  name                         = var.ContainerAppName
  container_app_environment_id = data.azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = var.ResourceGroupName
  revision_mode                = var.RevisionMode

  identity {
    type = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.appidentity.id]
  }

  registry {
    server   = var.ContainerRegistryServer
    identity = data.azurerm_user_assigned_identity.appidentity.id
  }

  # Container app ingress configuration
  dynamic "ingress" {
    for_each = var.TargetPort != null ? [1] : []  #verifies if the target port in the configuration
    content {
      external_enabled = var.ExternalEnabled
      target_port = var.TargetPort
      exposed_port = var.Transport == "tcp" ? (var.ExposedPort == null ? var.TargetPort : var.ExposedPort) : null
      transport = var.Transport
     #load balancing to container apps
      traffic_weight {
        latest_revision = true
        label           = var.TargetPort == "http" ? "latest" : null
        percentage = 100
      }

      #TODO: Implement ip_security_restriction block if needed
    }
  }

#defines how the container is configured
  template {
    # Scale / Replica configuration
    min_replicas = var.MinReplicas
    max_replicas = var.MaxReplicas

    # Volume definition where we reference the external storage
    dynamic "volume" {
      for_each = var.AzureFileStorageMounts
      content {
        name = "${volume.key}-volume"
        storage_name = volume.key
        storage_type = "AzureFile"
      }
    }

    container {
      # Basic container configuration
      name   = var.ContainerAppName
      image  = var.Image

      # Resource specification (for consumption model)
      cpu    = var.RequestedCPU
      memory = var.RequestedMemory

      # Readiness probe checks if the container ready to  receive traffic
      dynamic "readiness_probe" {
        for_each = var.TargetPort != null ? [1] : []
        content {
          port             = var.TargetPort
          transport        = var.Transport
          interval_seconds = 20


          #TODO: Implement ip_security_restriction block if needed
        }
      }

      # Volume mounts of the path of the container
      dynamic "volume_mounts" {
        for_each = var.AzureFileStorageMounts
        content {
          name = "${volume_mounts.key}-volume"
          path = volume_mounts.value
        }
      }

      # Environment unprottected variables added to the container
      dynamic "env" {
        for_each = var.EnvironmentVariables
        content {
          name     = env.key
          value    = env.value
        }
      }
    }
  }
}

# Add the Mount options if using Azure File Storage
resource "azapi_update_resource" "container_app_add_mount_options" {
  count = var.AzureFileStorageMountOptions != null && length(var.AzureFileStorageMountOptions) > 0 ? 1 : 0

  type        = "Microsoft.App/containerApps@2024-03-01"
  resource_id = azurerm_container_app.containerapp.id

  body = {
    properties = {
      template = {
        volumes = [
          {
            mountOptions = var.AzureFileStorageMountOptions
          }
        ]
        containers = [
          {
            # We need to recreate the env block to include the MOUNT_OPTIONS_SET
            env = [
              for key, value in merge(var.EnvironmentVariables, {MOUNT_OPTIONS_SET="true"}) :
                {
                  name     = key
                  value    = value
                }
            ]
          }
        ]
      }
    }
  }
#Links to the actua container app created above
  lifecycle {
    replace_triggered_by = [azurerm_container_app.containerapp]
  }
}

# Manually add the additional Port Mappings through the AzAPI module, since it's not supported by the azurerm_container_app provider
resource "azapi_update_resource" "container_app_add_additional_ports" {
  count = var.AdditionalTCPPorts != null && length(var.AdditionalTCPPorts) > 0 ? 1 : 0

  type        = "Microsoft.App/containerApps@2024-03-01"
  resource_id = azurerm_container_app.containerapp.id

  body = jsonencode({
    properties = {
      configuration = {
        ingress = {
          additionalPortMappings = [
            for port in var.AdditionalTCPPorts :
            {
              external = false
              targetPort = port
              exposedPort = port
            }
          ]
        }
      }
    }
  })
#Links to the actua container app created above
  lifecycle {
    replace_triggered_by = [azurerm_container_app.containerapp]
  }
}

