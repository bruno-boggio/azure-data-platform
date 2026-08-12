variable "name" {
  description = "Name of the Databricks workspace"
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

variable "vnet_id" {
  description = "ID of the virtual network for VNet injection"
  type        = string
}

variable "public_subnet_name" {
  description = "Name of the public subnet (load balancers)"
  type        = string
}

variable "private_subnet_name" {
  description = "Name of the private subnet (cluster workers)"
  type        = string
}

variable "tags" {
  description = "Tags applied to the databricks workspace"
  type        = map(string)
  default     = {}
}

variable "public_subnet_nsg_association_id" {
  description = "ID of the NSG association for the public subnet"
  type        = string
}

variable "private_subnet_nsg_association_id" {
  description = "ID of the NSG association for the private subnet"
  type        = string
}