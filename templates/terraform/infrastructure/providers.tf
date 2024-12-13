terraform {
  required_version = ">=1.10"

  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
  }
}

provider "azurerm" {
  features {}
    subscription_id = var.SubscriptionID
}