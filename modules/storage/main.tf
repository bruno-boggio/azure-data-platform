# ADLS Gen2 storage account for the data lake (bronze/silver/gold layers)
resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Enables hierarchical namespace, turning this into ADLS Gen2
  is_hns_enabled = true

  min_tls_version                = "TLS1_2"
  public_network_access_enabled  = true
  allow_nested_items_to_be_public = false
  network_rules {
    default_action = "Deny"
    ip_rules       = [var.allowed_ip]
    bypass         = ["AzureServices"]
  }

  tags = var.tags
}

# Data lake containers representing the medallion architecture layers
resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}