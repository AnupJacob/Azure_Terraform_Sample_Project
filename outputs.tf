output "az-public-ip-address" {
  value = "${azurerm_linux_virtual_machine.az-linux-vm.name} : ${data.azurerm_public_ip.az-data-ip.ip_address}"
}