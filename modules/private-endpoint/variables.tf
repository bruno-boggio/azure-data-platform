variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_id" {
  description = "ID of the virtual network where the DNS zone will be linked"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the private endpoint will be created"
  type        = string
}

variable "storage_account_id" {
  description = "ID of the storage account to connect privately"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account (used for resource naming)"
  type        = string
}

variable "tags" {
  description = "Tags applied to private endpoint resources"
  type        = map(string)
  default     = {}
}