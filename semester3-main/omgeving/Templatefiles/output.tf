output "fqdn" {
    value = module.network.vmss_public_ip_fqdn
}

output "jumpboxip" {
    value = module.jumpbox.jumphostip
}

output "wordpress_ip" {
    value = module.network.public_ip_address
}