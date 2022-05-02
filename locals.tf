locals {
  name = "fb-20220502"
  vnets = distinct(flatten([
    for k_vnet, v_vnet in var.vnets : {
      key           = k_vnet
      address_space = v_vnet.address_space
    }
  ]))
  subnets = distinct(flatten([
    for k_vnet, v_vnet in var.vnets : [
      for k_snet, v_snet in v_vnet.subnets : {
        vnet_ref         = k_vnet
        snet_key         = k_snet
        address_prefixes = v_snet.address_prefixes
      }
    ]
  ]))
}
