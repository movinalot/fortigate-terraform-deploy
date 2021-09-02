resource "random_id" "random_id" {
  keepers = {
    resource_group = azurerm_resource_group.resource_group.name
  }

  byte_length = 8
}

resource "azurerm_storage_account" "storage_account" {
  name                     = "diag${random_id.random_id.hex}"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
