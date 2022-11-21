output "fqdn" {
    value = module.network.vmss_public_ip_fqdn
}

output "jumpboxip" {
    value = module.jumpbox.jumphostip
}
