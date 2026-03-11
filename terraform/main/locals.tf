# locals {
#   backends = {
#     vm1 = module.vm1.vm_private_ip
#     vm2 = module.vm2.vm_private_ip
#   }
# }


locals {
  common_tags = merge(
    var.common_tags,
    { Environment = terraform.workspace }
  )
}