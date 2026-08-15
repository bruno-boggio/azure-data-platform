# Calls the resource-group module to create the main resource group
module "resource_group" {
  source = "../../modules/resource-group"

  name     = "rg-${var.project_name}-${var.environment}"
  location = var.location

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Calls the networking module to create the VNet and subnets
module "networking" {
  source = "../../modules/networking"

  vnet_name           = "vnet-${var.project_name}-${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Fetches information about the current Azure AD session (tenant, subscription)
data "azurerm_client_config" "current" {}

# Calls the key-vault module
module "key_vault" {
  source = "../../modules/key-vault"

  name                = "kv-${var.project_name}-${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Calls the storage module to create the ADLS Gen2 data lake
module "storage" {
  source = "../../modules/storage"

  name                = "st${var.project_name}${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  allowed_ip          = var.allowed_ip

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Calls the private-endpoint module to privately connect the storage account to the VNet
module "storage_private_endpoint" {
  source = "../../modules/private-endpoint"

  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  vnet_id              = module.networking.vnet_id
  subnet_id            = module.networking.private_endpoints_subnet_id
  storage_account_id   = module.storage.id
  storage_account_name = module.storage.name

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Calls the databricks module to create the workspace with VNet injection
module "databricks" {
  source = "../../modules/databricks"

  name                = "dbw-${var.project_name}-${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  vnet_id             = module.networking.vnet_id
  public_subnet_name  = module.networking.databricks_public_subnet_name
  private_subnet_name = module.networking.databricks_private_subnet_name

  public_subnet_nsg_association_id  = module.networking.databricks_public_subnet_nsg_association_id
  private_subnet_nsg_association_id = module.networking.databricks_private_subnet_nsg_association_id

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Calls the data-factory module
module "data_factory" {
  source = "../../modules/data-factory"

  name                = "adf-${var.project_name}-${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Grants the Data Factory's managed identity permission to read/write the storage account
resource "azurerm_role_assignment" "adf_storage_access" {
  scope                = module.storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.data_factory.identity_principal_id
}

# Calls the sql module to create the serving layer database
module "sql" {
  source = "../../modules/sql"

  name                = "sql-${var.project_name}-${var.environment}"
  database_name       = "sqldb-${var.project_name}"
  location            = "brazilsouth"
  resource_group_name = module.resource_group.name
  aad_admin_login     = "azpdip@outlook.com"
  aad_admin_object_id = "69394d62-0095-44aa-a890-8098b9817e3b"

  tags = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}