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