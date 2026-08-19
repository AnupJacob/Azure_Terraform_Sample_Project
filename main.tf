terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "az-resource-grp" {
  location = "az-resource-group"
  name     = "North-Europe"
  tags = {
    environment = "dev"
  }
}