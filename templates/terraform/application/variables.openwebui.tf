#Variables used by terraform to populate from tfvars file OpenWebUI Server in ingress controller app
variable "OpenWebUIName" {
    description = "Name of the OpenWebUI container app"
    type        = string
}

variable "OpenWebUIImage" {
    description = "Image for the OpenWebUI container app"
    type        = string
}

variable "OpenWebUICPU" {
    description = "CPU amount for the OpenWebUI container app"
    type        = string
}

variable "OpenWebUIMemory" {
    description = "Memory amount for the OpenWebUI container app"
    type        = string
}

variable "OpenWebUIPort" {
    description = "Port to expose the OpenWebUI container app on"
    type        = string
}

variable "OpenWebUITransport" {
    description = "Transport protocol for the OpenWebUI container app"
    type        = string
    default     = "auto"
}

variable "OpenWebUIExtenalEnabled" {
    description = "Transport protocol for the OpenWebUI container app"
    type        = bool
}

variable "OpenWebUIEnvironmentVariables" {
    description = "Environment variables for the setup of the OpenWebUI container app"
    type        = map(string)
    default     = {}
}

variable "OpenWebUIAzureFileStorageMounts" {
    description = "Environment variables for mounting storage"
    type        = map(string)
    default     = {}
}

variable "OpenWebUIAzureFileStorageMountOptions" {
    description = "Mount options for the Azure file storage"
    type        = string
    default     = ""
}