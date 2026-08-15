variable "name" {
  description = "Name of the SQL Server (must be globally unique)"
  type        = string
}

variable "database_name" {
  description = "Name of the SQL Database"
  type        = string
  default     = "sqldb-datplatform"
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "aad_admin_login" {
  description = "Azure AD login name of the SQL admin"
  type        = string
}

variable "aad_admin_object_id" {
  description = "Azure AD object ID of the SQL admin"
  type        = string
}

variable "tags" {
  description = "Tags applied to SQL resources"
  type        = map(string)
  default     = {}
}