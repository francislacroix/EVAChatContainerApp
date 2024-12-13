variable "SubscriptionID" {
    description = "Name of the resource group in which to create the container registry"
    type        = string
}

variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the container app environment"
    type        = string
}

variable "ResourceLocation" {
    description = "Location of the resource group in which to create the container app environment"
    type        = string
    default     = "canadacentral"
}

variable "ContainerAppEnvironmentName" {
    description = "Name of the container app environment"
    type        = string
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

variable "ZoneRedundancyEnabled" {
    description = "Enable zone redundancy for the container app environment"
    type        = bool
    default     = false
}

variable "LogAnalyticsWorkspaceID" {
    description = "ID of the Log Analytics workspace to associate with the container app environment"
    type        = string
    default     = null
}

variable "StorageAccountName" {
    description = "Name of the storage account to attach to the container app environment"
    type        = string
    default     = null
}

variable "FileShareNames" {
    description = "Name of the file share to attach to the container app environment"
    type        = list(string)
    default     = null
}

variable "StorageAccessKey" {
    description = "Access key for the storage account"
    type        = string
    default     = null
    sensitive   = true
}