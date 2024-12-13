# Reference the existing subnet
data "azurerm_subnet" "container_app_environment_subnet" {
    name                 = var.SubnetName
    virtual_network_name = var.VirtualNetworkName
    resource_group_name  = var.VirtualNetworkResourceGroupName
}

# Create the container app enironment
resource "azurerm_container_app_environment" "container_app_environment" {
  name                = var.ContainerAppEnvironmentName
  resource_group_name = var.ResourceGroupName
  location            = var.ResourceLocation

  infrastructure_subnet_id        = data.azurerm_subnet.container_app_environment_subnet.id
  internal_load_balancer_enabled  = true
  mutual_tls_enabled              = true

  zone_redundancy_enabled = var.ZoneRedundancyEnabled
  log_analytics_workspace_id = var.LogAnalyticsWorkspaceID

  lifecycle {
    ignore_changes = [
      tags,
      infrastructure_resource_group_name
    ]
  }
}

#Create File share to store ActiveMQ related files
resource "azurerm_container_app_environment_storage" "container_app_environment_storage" {
  for_each = toset(var.FileShareNames)
  
  name                         = each.key
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  account_name                 = var.StorageAccountName
  share_name                   = each.key
  access_key                   = var.StorageAccessKey
  access_mode                  = "ReadWrite"
}

