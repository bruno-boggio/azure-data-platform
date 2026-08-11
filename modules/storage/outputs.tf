output "id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.this.name
}

output "primary_dfs_endpoint" {
  description = "Primary Data Lake (ADLS Gen2) endpoint"
  value       = azurerm_storage_account.this.primary_dfs_endpoint
}