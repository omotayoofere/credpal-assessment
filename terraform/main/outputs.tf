output "vnet_id" {
  value = module.vnet.vnet_id
}

output "private_subnet_id" {
  value = module.private_subnet.subnet_id
}

output "appgateway_subnet_id" {
  value = module.appgateway_subnet.subnet_id
}

output "vm1_id" {
  value = module.vm1.vm_id
}

output "vm1_private_ip" {
  value = module.vm1.vm_private_ip
}

output "vm1_nic_id" {
  value = module.vm1.vm_nic_id
}

output "vm2_id" {
  value = module.vm2.vm_id
}

output "vm2_private_ip" {
  value = module.vm2.vm_private_ip
}

output "vm2_nic_id" {
  value = module.vm2.vm_nic_id
}
