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

variable "allowed_ip" {
  description = "Public IP allowed to access data platform resources (your machine)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}