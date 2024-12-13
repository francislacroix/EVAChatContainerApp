#Variables used by terraform to populate from tfvars file for OpenWebUIPipelines app
variable "OpenWebUIPipelinesName" {
    description = "Name of the OpenWebUIPipelines container app"
    type        = string
}

variable "OpenWebUIPipelinesImage" {
    description = "Image for the OpenWebUIPipelines container app"
    type        = string
}

variable "OpenWebUIPipelinesWorkloadProfile" {
    description = "Workload profile for the OpenWebUIPipelines container app"
    type        = string
    default     = null
}

variable "OpenWebUIPipelinesCPU" {
    description = "CPU amount for the OpenWebUIPipelines container app"
    type        = string
}

variable "OpenWebUIPipelinesMemory" {
    description = "Memory amount for the OpenWebUIPipelines container app"
    type        = string
}

variable "OpenWebUIPipelinesPort" {
    description = "Port to expose the OpenWebUIPipelines container app on"
    type        = string
}

variable "OpenWebUIPipelinesTransport" {
    description = "Transport protocol for the OpenWebUIPipelines container app"
    type        = string
    default     = "auto"
}

variable "OpenWebUIPipelinesEnvironmentVariables" {
    description = "Environment variables for the setup of the OpenWebUIPipelines container app"
    type        = map(string)
    default     = {}
}

variable "OpenWebUIPipelinesAzureFileStorageMounts" {
    description = "Environment variables for mounting storage"
    type        = map(string)
    default     = {}
}