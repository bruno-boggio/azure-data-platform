output "id" {
  description = "ID of the data factory"
  value       = azurerm_data_factory.this.id
}

output "name" {
  description = "Name of the data factory"
  value       = azurerm_data_factory.this.name
}

output "identity_principal_id" {
  description = "Principal ID of the data factory's managed identity"
  value       = azurerm_data_factory.this.identity[0].principal_id
}