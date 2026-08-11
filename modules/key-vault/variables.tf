variable "name" {
  description = "Name of the key vault"
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

variable "tenant_id" {
  description = "Azure AD tenant ID used by the key vault"
  type        = string
}

variable "purge_protection_enabled" {
  description = "Whether purge protection is enabled (should be true in prod)"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to the key vault"
  type        = map(string)
  default     = {}
}