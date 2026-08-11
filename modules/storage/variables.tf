variable "name" {
  description = "Name of the storage account (must be globally unique, lowercase, 3-24 chars)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags applied to the storage account"
  type        = map(string)
  default     = {}
}

variable "allowed_ip" {
  description = "Public IP allowed to access the storage account (your machine, for Terraform/testing)"
  type        = string
}