output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "private_endpoints_subnet_id" {
  description = "ID of the private endpoints subnet"
  value       = azurerm_subnet.private_endpoints.id
}

output "databricks_public_subnet_id" {
  description = "ID of the databricks public subnet"
  value       = azurerm_subnet.databricks_public.id
}

output "databricks_private_subnet_id" {
  description = "ID of the databricks private subnet"
  value       = azurerm_subnet.databricks_private.id
}