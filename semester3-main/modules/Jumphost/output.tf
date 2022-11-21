output jumphostip {
  value       = azurerm_public_ip.jumpbox.ip_address
}

output "jumpbox_public_ip_fqdn" {
   value = azurerm_public_ip.jumpbox.fqdn
}
