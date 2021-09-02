// Resource Group

resource "azurerm_resource_group" "resource_group" {
  name     = var.tag_environment
  location = var.location

  tags = {
    environment = var.tag_environment
  }
}

resource "random_string" "random_apikey" {
  length  = 30
  special = false

  keepers = {
    resource_group = azurerm_resource_group.resource_group.name
  }
}