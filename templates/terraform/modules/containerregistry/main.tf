# Reference the existing subnet
data "azurerm_virtual_network" "private_endpoint_vnet" {
  name                 = var.VirtualNetworkName
  resource_group_name  = var.VirtualNetworkResourceGroupName
}

data "azurerm_subnet" "private_endpoint_subnet" {
    name                 = var.SubnetName
    virtual_network_name = var.VirtualNetworkName
    resource_group_name  = var.VirtualNetworkResourceGroupName
}

# Create the container registry
resource "azurerm_container_registry" "container_registry" {
  name                = var.ContainerRegistryName
  resource_group_name = var.ResourceGroupName
  location            = var.ResourceLocation
  sku                 = "Premium" # Premium SKU is required for VNet private endpoints and network rule sets
  admin_enabled       = false

  # TODO: Uncomment the below line to disable public network access
  public_network_access_enabled = true
  # public_network_access_enabled = false

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create the private endpoint for the container registry
resource "azurerm_private_endpoint" "container_registry_private_endpoint" {
  name                = "${var.ContainerRegistryName}-pe"
  resource_group_name = var.ResourceGroupName
  location            = var.ResourceLocation
  subnet_id           = data.azurerm_subnet.private_endpoint_subnet.id

  private_service_connection {
    name                           = "${var.ContainerRegistryName}-connection"
    private_connection_resource_id = azurerm_container_registry.container_registry.id
    subresource_names              = ["registry"]
    is_manual_connection           = false 
  }

  private_dns_zone_group {
    name                 = "acr-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr_dns_zone.id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create private DNS zone
resource "azurerm_private_dns_zone" "acr_dns_zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.ResourceGroupName
}

# Create virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "acr_dns_zone_vnet_link" {
  name                  = "acr-vnet-link"
  resource_group_name   = var.ResourceGroupName
  private_dns_zone_name = azurerm_private_dns_zone.acr_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.private_endpoint_vnet.id
}