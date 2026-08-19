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
  location = var.az-location
  name     = "az-resource-group"
  tags = {
    environment = var.environment
  }
}

resource "azurerm_public_ip" "az_public_ip" {
  allocation_method   = var.ip-allocation
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az-public-ip"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_linux_virtual_machine" "az-linux-vm" {
  admin_username        = var.user
  location              = azurerm_resource_group.az-resource-grp.location
  name                  = "az-linux-vm"
  network_interface_ids = [azurerm_network_interface.az-nic.id]
  resource_group_name   = azurerm_resource_group.az-resource-grp.name
  size                  = "Standard_B1s"
  custom_data           = filebase64("customdata.tpl")

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username   = var.user
    public_key = file("~/.ssh/id_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  provisioner "local-exec" {
    command = templatefile("linux-ssh-script.tpl", {
      hostname     = self.public_ip_address,
      user         = var.user,
      identityfile = "~/.ssh/id_rsa"
    })
    interpreter = ["bash", "-c"]
  }
  tags = {
    environment = var.environment
  }
}