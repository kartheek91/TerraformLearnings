# resource "random_string" "storage_name" {
#   length  = 8
#   special = false    
#   upper   = false  
# }

# resource "azurerm_resource_group" "rg" {
#   name     = "sails${random_string.storage_name.result}"
#   location = var.location
# }
module "resourcegroup" {
  source  = "app.terraform.io/kartheek91/resourcegroup/azure"
  version = "0.0.3"
  # insert required variables here
  name = "sailsskipper2024"
  location = var.location
}
resource "azurerm_storage_account" "asa" {
  name                     = "sailsskipper2024account"
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
  name                  = "sailsskipper2024container"
  storage_account_name  = azurerm_storage_account.asa.name
  container_access_type = "private"
}

# Upload a sample file to the Azure Storage Container
resource "azurerm_storage_blob" "sample_file_1" {
  name                   = "sample-file-1.txt"
  storage_account_name   = azurerm_storage_account.asa.name
  storage_container_name = azurerm_storage_container.asc.name
  type                   = "Block"
  source                 = "files/sample-file-11.txt"
}