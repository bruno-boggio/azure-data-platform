# Data Factory instance that orchestrates the ingestion pipeline
resource "azurerm_data_factory" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  # System-assigned managed identity — used to authenticate to Storage/Key Vault
  # without storing any credentials
  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}