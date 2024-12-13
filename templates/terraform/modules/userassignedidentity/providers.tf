terraform {
  required_version = ">=1.10"

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">=4.13"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.SubscriptionID
}