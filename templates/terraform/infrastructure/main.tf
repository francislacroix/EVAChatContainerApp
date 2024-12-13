# Create the resource group that will contain the app infrustructure resources
resource "azurerm_resource_group" "infrastructureresourcegroup" {
  name     = var.ResourceGroupName
  location = var.ResourceLocation
}

# Create the container registry
module "ContainerRegistry" {
  source = "../modules/containerregistry"
  
  SubscriptionID                  = var.SubscriptionID
  ResourceGroupName               = azurerm_resource_group.infrastructureresourcegroup.name
  ResourceLocation                = azurerm_resource_group.infrastructureresourcegroup.location

  ContainerRegistryName           = var.ContainerRegistryName
  VirtualNetworkResourceGroupName = var.VirtualNetworkResourceGroupName
  VirtualNetworkName              = var.VirtualNetworkName
  SubnetName                      = var.PrivateEndpointSubnetName
}

#Call to Key Vault module
module "KeyVault" {
  source = "../modules/keyvault"

  SubscriptionID                  = var.SubscriptionID
  ResourceGroupName               = azurerm_resource_group.infrastructureresourcegroup.name
  ResourceLocation                = azurerm_resource_group.infrastructureresourcegroup.location

  KeyVaultName                    = var.KeyVaultName
  VirtualNetworkResourceGroupName = var.VirtualNetworkResourceGroupName
  VirtualNetworkName              = var.VirtualNetworkName
  SubnetName                      = var.PrivateEndpointSubnetName
}

#Call to Storage Account module
module "StorageAcount" {
  source = "../modules/storageaccount"

  SubscriptionID                  = var.SubscriptionID
  ResourceGroupName               = azurerm_resource_group.infrastructureresourcegroup.name
  ResourceLocation                = azurerm_resource_group.infrastructureresourcegroup.location

  StorageAccountName              = var.StorageAccountName
  FileShareNames                  = var.FileShareNames

  VirtualNetworkResourceGroupName = var.VirtualNetworkResourceGroupName
  VirtualNetworkName              = var.VirtualNetworkName
  SubnetName                      = var.PrivateEndpointSubnetName
}

#Call to Container App Environment module
module "ContainerAppEnvironment" {
  source = "../modules/containerappenvironment"
  
  SubscriptionID                  = var.SubscriptionID
  ResourceGroupName               = azurerm_resource_group.infrastructureresourcegroup.name
  ResourceLocation                = azurerm_resource_group.infrastructureresourcegroup.location

  ContainerAppEnvironmentName     = var.ContainerAppEnvironmentName
  
  VirtualNetworkResourceGroupName = var.VirtualNetworkResourceGroupName
  VirtualNetworkName              = var.VirtualNetworkName
  SubnetName                      = var.ContainerAppEnvironmentSubnetName

  StorageAccountName              = var.StorageAccountName
  FileShareNames                  = var.FileShareNames
  StorageAccessKey                = module.StorageAcount.StorageAccountKey
}

module "UserAssignedIdentity" {
  source = "../modules/userassignedidentity"

  SubscriptionID                  = var.SubscriptionID
  ResourceGroupName               = azurerm_resource_group.infrastructureresourcegroup.name
  ResourceLocation                = azurerm_resource_group.infrastructureresourcegroup.location

  ContainerRegistryName           = var.ContainerRegistryName

  AppIdentityName                 = var.AppIdentityName
}