variable "SubscriptionID" {
    description = "Name of the resource group in which to create the container registry"
    type        = string
}

variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the container registry"
    type        = string
}

variable "ResourceLocation" {
    description = "Location of the resource group in which to create the container registry"
    type        = string
    default     = "canadacentral"
}

variable "VirtualNetworkResourceGroupName" {
    description = "Name of the resource group which contains the virtual network to attach the ACR"
    type        = string
}

variable "VirtualNetworkName" {
    description = "Name of the virtual network to attach the ACR"
    type        = string
}

variable "PrivateEndpointSubnetName" {
    description = "Name of the subnet to attach the ACR"
    type        = string
}

variable "ContainerAppEnvironmentSubnetName" {
    description = "Name of the subnet to attach the ACR"
    type        = string
}

variable "ContainerRegistryName" {
    description = "Name of the container registry"
    type        = string
}

variable "ContainerAppEnvironmentName" {
    description = "Name of the container registry"
    type        = string
}

# Variable to store key vault name
variable "KeyVaultName" {
    description = "Name of the key vault"
    type        = string
}

variable "StorageAccountName" {
  description = "Name of the Storage Account."
  type        = string
}

variable "FileShareNames" {
  description = "Name of the Storage File Share."
  type        = list(string)
}

variable "AppIdentityName" {
    description = "Name of the user assigned identity"
    type        = string
}