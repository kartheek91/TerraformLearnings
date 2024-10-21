# Generate a random string for resource names
resource "random_string" "storage_name" {
  length  = 8
  special = false    # Avoid special characters for compatibility
  upper   = false    # Azure resource names are case-insensitive
}

# Create an Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "sails${random_string.storage_name.result}"
  location = var.location
}

# Create an Azure Storage Account
resource "azurerm_storage_account" "asa" {
  name                     = "sails${random_string.storage_name.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  # The `min_tls_version` attribute is required for the storage account in some configurations
  min_tls_version          = "TLS1_2" 

  tags = {
    environment = "staging"
  }
}

# Create an Azure Storage Container
resource "azurerm_storage_container" "asc" {
  name                  = "sails${random_string.storage_name.result}"
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
