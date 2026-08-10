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