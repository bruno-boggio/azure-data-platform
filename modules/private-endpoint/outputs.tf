output "private_endpoint_id" {
  description = "ID of the storage private endpoint"
  value       = azurerm_private_endpoint.storage_blob.id
}

output "private_dns_zone_id" {
  description = "ID of the private DNS zone for blob storage"
  value       = azurerm_private_dns_zone.storage_blob.id
}