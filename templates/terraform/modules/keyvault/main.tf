data "azurerm_client_config" "current" {}

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

#Create Azure key Vault
resource "azurerm_key_vault" "keyvault" {
  name                       = var.KeyVaultName
  location                   = var.ResourceLocation
  resource_group_name        = var.ResourceGroupName
  sku_name = "standard"

  tenant_id                  = data.azurerm_client_config.current.tenant_id
  
  purge_protection_enabled   = false
  enable_rbac_authorization = true
  public_network_access_enabled = false


#Ignore Resource Group tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

#set Private endpoint for Keyvault
resource "azurerm_private_endpoint" "kv_pe" {
  name                = "kv-endpoint"
  location            = var.ResourceLocation
  resource_group_name = var.ResourceGroupName
  subnet_id           = data.azurerm_subnet.private_endpoint_subnet.id

  private_service_connection {
    name                           = "${var.KeyVaultName}-connection"
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    is_manual_connection           = false
    subresource_names              = ["Vault"]
  }

  private_dns_zone_group {
    name                 = "kv-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.key_vault_dns_zone.id]
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Create private DNS zone
resource "azurerm_private_dns_zone" "key_vault_dns_zone" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.ResourceGroupName
}

# Create virtual network link
resource "azurerm_private_dns_zone_virtual_network_link" "key_vault_dns_zone_vnet_link" {
  name                  = "key_vault-vnet-link"
  resource_group_name   = var.ResourceGroupName
  private_dns_zone_name = azurerm_private_dns_zone.key_vault_dns_zone.name
  virtual_network_id    = data.azurerm_virtual_network.private_endpoint_vnet.id
}

  