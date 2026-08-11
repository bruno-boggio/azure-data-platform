# Key Vault used to store secrets, connection strings and credentials
resource "azurerm_key_vault" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  enable_rbac_authorization = true
  purge_protection_enabled  = var.purge_protection_enabled

  public_network_access_enabled = false

  tags = var.tags
}