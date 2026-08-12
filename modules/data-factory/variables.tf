variable "name" {
  description = "Name of the Data Factory instance"
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
  description = "Tags applied to the data factory"
  type        = map(string)
  default     = {}
}