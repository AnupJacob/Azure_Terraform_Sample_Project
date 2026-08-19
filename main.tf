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

resource "azurerm_network_security_group" "az_network_grp" {
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az_network_group"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "az_virtual_nwk" {
  address_space       = ["10.122.10.10/16"]
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az_virtual_network"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
}