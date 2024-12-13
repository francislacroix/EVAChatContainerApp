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

variable "ContainerRegistryName" {
    description = "Name of the container registry"
    type        = string
}

variable "VirtualNetworkResourceGroupName" {
    description = "Name of the resource group which contains the virtual network to attach the ACR"
    type        = string
}

variable "VirtualNetworkName" {
    description = "Name of the virtual network to attach the ACR"
    type        = string
}

variable "SubnetName" {
    description = "Name of the subnet to attach the ACR"
    type        = string
}

variable "AllowedCIDRBlocks" {
    description = "List of CIDR blocks to allow access to the container registry"
    type        = list(string)
    default     = null
}