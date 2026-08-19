
resource "azurerm_virtual_network" "az_virtual_nwk" {
  address_space       = var.az-virtual-network-address-space
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az_virtual_network"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_security_rule" "az" {
  name                        = "az-rule123"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-resource-grp.name
  network_security_group_name = azurerm_network_security_group.az_network_sec_grp.name
}


resource "azurerm_network_security_group" "az_network_sec_grp" {
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az_network_group"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
  tags = {
    environment = var.environment
  }
}

resource "azurerm_network_interface" "az-nic" {
  location            = azurerm_resource_group.az-resource-grp.location
  name                = "az-network-interface"
  resource_group_name = azurerm_resource_group.az-resource-grp.name
  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = var.ip-allocation
    public_ip_address_id          = azurerm_public_ip.az_public_ip.id
  }
  tags = {
    environment = var.environment
  }
}
