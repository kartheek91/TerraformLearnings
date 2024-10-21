
resource "azurerm_resource_group" "rg" {
  name     = "skipperresourcegroup"
  location = var.location
}
resource "azurerm_storage_account" "asa" {
  name                     = "skipperstorageaccount"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
# Create an Azure Storage Container
resource "azurerm_storage_container" "asc" {
  name                  = "skipper-container"
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