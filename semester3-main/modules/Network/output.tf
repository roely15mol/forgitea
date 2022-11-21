output "vmss_public_ip_fqdn" {
   value = azurerm_public_ip.IP.fqdn
}

output "subnet" {
   value = azurerm_subnet.SN.id
}

output "public_ip" {
   value = azurerm_public_ip.IP.id
}

output "public_ip_address" {
   value = azurerm_public_ip.IP.ip_address
}