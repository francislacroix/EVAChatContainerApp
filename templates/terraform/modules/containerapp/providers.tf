terraform {
  required_version = ">=1.10"

  required_providers {
    azapi = {
      source = "azure/azapi" #Required for additional TCP ports configuration
      version = ">=2.1"
    }
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