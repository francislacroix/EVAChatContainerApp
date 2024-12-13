variable "SubscriptionID" {
    description = "Name of the resource group in which to create the user assigned identity"
    type        = string
}

variable "ResourceGroupName" {
    description = "Name of the resource group in which to create the user assigned identity"
    type        = string
}

variable "ResourceLocation" {
    description = "Location of the resource group in which to create the user assigned identity"
    type        = string
    default     = "canadacentral"
}

variable "AppIdentityName" {
    description = "Name of the user assigned identity"
    type        = string
}

variable "ContainerRegistryName" {
    description = "Name of the user assigned identity"
    type        = string
}