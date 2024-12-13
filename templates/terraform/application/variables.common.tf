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

variable "InfrastructureResourceGroupName" {
    description = "Name of the resource group in which the Container App Environment is located"
    type        = string
    default     = null
}

variable "ContainerAppEnvironmentName" {
    description = "Name of the Container App Environment to host the Container App"
    type        = string
}

variable "ContainerRegistryServer" {
    description = "Name of the container registry server"
    type        = string
}