# SQL Server (logical server) that hosts the database
resource "azurerm_mssql_server" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "12.0"

  # Azure AD-only authentication — no SQL username/password
  azuread_administrator {
    login_username = var.aad_admin_login
    object_id      = var.aad_admin_object_id
    azuread_authentication_only = true
  }

  public_network_access_enabled = false

  tags = var.tags
}

# SQL Database used as the serving layer (Gold data)
resource "azurerm_mssql_database" "this" {
  name        = var.database_name
  server_id   = azurerm_mssql_server.this.id
  sku_name    = "Basic"
  max_size_gb = 2

  tags = var.tags
}