//Reference to existing Subnet
data "azurerm_virtual_network" "private_endpoint_vnet" {
  name                 = var.VirtualNetworkName
  resource_group_name  = var.VirtualNetworkResourceGroupName
}

data "azurerm_subnet" "private_endpoint_subnet" {
  name                 = var.SubnetName
  virtual_network_name = var.VirtualNetworkName
  resource_group_name  = var.VirtualNetworkResourceGroupName
}

resource "azurerm_storage_account" "storageaccount" {
  name                          = var.StorageAccountName
  resource_group_name           = var.ResourceGroupName
  location                      = var.ResourceLocation
  account_tier                  = "Standard"
  account_replication_type      = "LRS"

  https_traffic_only_enabled    = true
  # TODO: Uncomment the below line to disable public network access
  # public_network_access_enabled = false
  public_network_access_enabled = true

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_storage_share" "fileshares" {
    for_each = toset(var.FileShareNames)
    
    name                 = each.key
    storage_account_id   = azurerm_storage_account.storageaccount.id 
    quota                = 100
}

#Create Private Endpoint
resource "azurerm_private_endpoint" "fs_pe" {
  name                = "fs-endpoint"
  location            = var.ResourceLocation
  resource_group_name = var.ResourceGroupName
  subnet_id           = data.azurerm_subnet.private_endpoint_subnet.id

  private_service_connection {
    name                           = "${var.StorageAccountName}-connection"
    private_connection_resource_id = azurerm_storage_account.storageaccount.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }

  private_dns_zone_group {
    name                 = "sa-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.file_share_dns_zone.id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create private DNS zone
resource "azurerm_private_dns_zone" "file_share_dns_zone" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.ResourceGroupName
}

# Create virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "file_share_dns_zone_vnet_link" {
  name                  = "sa-vnet-link"
  resource_group_name   = var.ResourceGroupName
  private_dns_zone_name = azurerm_private_dns_zone.file_share_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.private_endpoint_vnet.id
}