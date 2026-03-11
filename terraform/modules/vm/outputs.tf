output "vm_id" {
    value = azurerm_linux_virtual_machine.main.id
}

output "vm_private_ip" {
    value = azurerm_linux_virtual_machine.main.private_ip_address
}

output "vm_nic_id" {
    value = azurerm_linux_virtual_machine.main.network_interface_ids[0]
}