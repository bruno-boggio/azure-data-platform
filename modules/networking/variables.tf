variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the virtual network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_endpoints_subnet_prefix" {
  description = "Address prefix for the private endpoints subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "databricks_subnet_prefix" {
  description = "Address prefix for the databricks subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the network resources will be created"
  type        = string
}

variable "tags" {
  description = "Tags applied to networking resources"
  type        = map(string)
  default     = {}
}