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

resource "azurerm_public_ip" "az_public_ip" {
  allocation_method   = "Dynamic"
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az-public-ip"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
  tags = {
    environment = "dev"
  }
}