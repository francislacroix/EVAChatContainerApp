#This is the entry point for deploying container apps

# Create the resource group that will contain the app resources
resource "azurerm_resource_group" "applicationresourcegroup" { 
  name     = var.ResourceGroupName
  location = var.ResourceLocation
}

module "OpenWebUIContainerApp" {
  source = "../modules/containerapp"

  ContainerAppEnvironmentName                 = var.ContainerAppEnvironmentName
  AppIdentityName                             = var.AppIdentityName
  InfrastructureResourceGroupName             = var.InfrastructureResourceGroupName != null ? var.InfrastructureResourceGroupName : var.ResourceGroupName
  SubscriptionID                              = var.SubscriptionID
  ResourceGroupName                           = azurerm_resource_group.applicationresourcegroup.name
  ContainerAppName                            = var.OpenWebUIName
  Image                                       = var.OpenWebUIImage
  ContainerRegistryServer                     = var.ContainerRegistryServer
  RequestedCPU                                = var.OpenWebUICPU
  RequestedMemory                             = var.OpenWebUIMemory
  TargetPort                                  = var.OpenWebUIPort
  Transport                                   = var.OpenWebUITransport
  ExternalEnabled                             = var.OpenWebUIExtenalEnabled
  EnvironmentVariables                        = var.OpenWebUIEnvironmentVariables
  AzureFileStorageMounts                      = var.OpenWebUIAzureFileStorageMounts
  AzureFileStorageMountOptions                = var.OpenWebUIAzureFileStorageMountOptions
}

# Create the OpenWebUIPipelines container 
module "OpenWebUIPipelinesContainerApp" {
  source = "../modules/containerapp"
#required paramaeters to create OpenWebUIPipelines container app     
  ContainerAppEnvironmentName                 = var.ContainerAppEnvironmentName
  AppIdentityName                             = var.AppIdentityName
  InfrastructureResourceGroupName             = var.InfrastructureResourceGroupName != null ? var.InfrastructureResourceGroupName : var.ResourceGroupName
  SubscriptionID                              = var.SubscriptionID
  ResourceGroupName                           = azurerm_resource_group.applicationresourcegroup.name
  ContainerAppName                            = var.OpenWebUIPipelinesName
  Image                                       = var.OpenWebUIPipelinesImage
  ContainerRegistryServer                     = var.ContainerRegistryServer
  RequestedCPU                                = var.OpenWebUIPipelinesCPU
  RequestedMemory                             = var.OpenWebUIPipelinesMemory
  TargetPort                                  = var.OpenWebUIPipelinesPort
  Transport                                   = var.OpenWebUIPipelinesTransport
  EnvironmentVariables                        = var.OpenWebUIPipelinesEnvironmentVariables
}