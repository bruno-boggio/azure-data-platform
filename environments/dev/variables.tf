variable "project_name" {
  description = "Short project name used in resource naming"
  type        = string
  default     = "datplatform"
}

variable "environment" {
  description = "Environment name (dev, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}