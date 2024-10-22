resource "random_string" "storage_name" {
  length  = 8
  special = false    
  upper   = false  
}

# resource "azurerm_resource_group" "rg" {
#   name     = "sails${random_string.storage_name.result}"
#   location = var.location
# }
module "resourcegroup" {
  source  = "app.terraform.io/kartheek91/resourcegroup/azure"
  version = "0.0.3"
  # insert required variables here
  name = "sails${random_string.storage_name.result}"
  location = var.location
}
resource "azurerm_storage_account" "asa" {
  name                     = "sails${random_string.storage_name.result}"
  resource_group_name      = module.resourcegroup.name
  location                 = module.resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "develop"
  }
}
# Create an Azure Storage Container
resource "azurerm_storage_container" "asc" {
  name                  = "skipper-${random_string.storage_name.result}"
  storage_account_name  = azurerm_storage_account.asa.name
  container_access_type = "private"
}

# Upload a sample file to the Azure Storage Container
resource "azurerm_storage_blob" "sample_file_1" {
  name                   = "sample-file-1.txt"
  storage_account_name   = azurerm_storage_account.asa.name
  storage_container_name = azurerm_storage_container.asc.name
  type                   = "Block"
  source                 = "files/sample-file-1.txt"
}

resource "azurerm_storage_blob" "sample_file_2" {
  name                   = "sample-file-2.txt"
  storage_account_name   = azurerm_storage_account.asa.name
  storage_container_name = azurerm_storage_container.asc.name
  type                   = "Block"
  source                 = "files/sample-file-2.txt"
}