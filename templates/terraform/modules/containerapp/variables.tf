variable "SubscriptionID" {
    description = "Name of the resource group in which to create the container registry"
    type        = string
}

variable "ContainerAppEnvironmentName" {
    description = "Name of the container registry"
    type        = string
}

variable "InfrastructureResourceGroupName" {
    description = "Name of the container registry"
    type        = string
}

variable "ContainerAppName" {
    description = "Name of the container app"
    type        = string
  
}

variable "ResourceGroupName" {
    description = "Name of the container app resource group"
    type        = string
}

variable "ContainerRegistryServer" {
    description = "Name of the container registry server"
    type        = string
}

variable "Image" {
    description = "Name of the container app image"
    type        = string
}

variable "MinReplicas" {
    description = "Minimum replicas for the container app"
    type        = number
    default     = 1
}

variable "MaxReplicas" {
    description = "Maximum replicas for the container app"
    type        = number
    default     = 1
}

variable "RequestedCPU" {
    description = "Requested CPU for the container app"
    type        = string
}

variable "RequestedMemory" {
    description = "Requested memory for the container app"
    type        = string
}

variable "TargetPort" {
    description = "Port for the container app"
    type        = string
    default     = null
}

variable "AdditionalTCPPorts" {
    description = "Additional TCP ports for the container app"
    type        = list(string)
    default     = []
}

variable "ExposedPort" {
    description = "Exposed port for the container app"
    type        = string
    default     = null
}

variable "Transport" {
    description = "Transport for the container app"
    type        = string
    default     = "auto"
}

variable "RevisionMode" {
    description = "Revision mode for the container app"
    type        = string
    default     = "Single"
}

variable "ExternalEnabled" {
    description = "External enabled for the container app"
    type        = bool
    default     = false
}

variable "EnvironmentVariables" {
    description = "Environment variables for the container app"
    type        = map(string)
    default     = {}
}

variable "AzureFileStorageMounts" {
    description = "Name of the Azure file storage"
    type        = map(string)
    default     = {}
}

variable "AppIdentityName" {
    description = "Name of the user assigned identity"
    type        = string
}


