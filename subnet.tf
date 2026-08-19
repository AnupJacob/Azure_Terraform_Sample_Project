resource "azurerm_subnet" "az_subnet" {
  name                 = "az-subnet"
  address_prefixes     = ["10.122.0.2"]
  resource_group_name  = azurerm_resource_group.az-resource-grp.name
  virtual_network_name = azurerm_virtual_network.az_virtual_nwk.name
}

resource "azurerm_subnet_network_security_group_association" "az-subnet_nwk_association" {
  network_security_group_id = azurerm_network_security_group.az_network_sec_grp.id
  subnet_id                 = azurerm_subnet.az_subnet.id
}
