variable "SubscriptionID" {
    description = "Name of the resource group in which to create the container registry"
    type        = string
}

variable "ResourceGroupName" {
  description = "The name of the resource group"
}

variable "ResourceLocation" {
  type        = string
  description = "The name of the Resource Group Location."
}

variable "VirtualNetworkResourceGroupName" {
    description = "Name of the resource group which contains the virtual network to attach the container app environment"
    type        = string
}

variable "VirtualNetworkName" {
    description = "Name of the virtual network to attach the container app environment"
    type        = string
}

variable "SubnetName" {
    description = "Name of the subnet to attach the container app environment"
    type        = string
}

variable "StorageAccountName" {
  type        = string
  description = "The name of the Storage Account."
}

variable "FileShareNames" {
  type        = list(string)
  description = "The name of the Storage File Shares."
}