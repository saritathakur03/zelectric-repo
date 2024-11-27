terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.10.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "e218c587-9161-4518-91c3-1eb54c4095e8"
}
