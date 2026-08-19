
data "azurerm_public_ip" "az-data-ip" {
  name                = azurerm_public_ip.az_public_ip.name
  resource_group_name = azurerm_resource_group.az-resource-grp.name
}