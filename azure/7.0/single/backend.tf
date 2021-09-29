terraform {
  backend "azurerm" {
    resource_group_name  = "jmcdonough-utility"
    storage_account_name = "jmcdonoughutility"
    container_name       = "terraform"
    key                  = "terraform-single-api-token.terraform.tfstate"
  }
}