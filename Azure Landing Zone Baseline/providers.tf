terraform {
  required_providers {
    azurerm = {
      version = "= 3.37.0"
    }
  }
}

provider "azurerm" {
  features {}
}
