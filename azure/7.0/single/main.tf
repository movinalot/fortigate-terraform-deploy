// Resource Group

resource "azurerm_resource_group" "resource_group" {
  name     = var.tag_environment
  location = var.location

  tags = {
    environment = var.tag_environment
  }
}

resource "random_string" "apikey" {
  length  = (var.vm_version == "6.4.2" ? 16 : 30)
  special = false
}