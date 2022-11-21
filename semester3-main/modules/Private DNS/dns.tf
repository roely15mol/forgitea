# Create a Private DNS Zone
resource "azurerm_private_dns_zone" "private-dns" {
  name = var.name-private-dns
  resource_group_name = var.rgn
}

# Link the Private DNS Zone with the VNET
resource "azurerm_private_dns_zone_virtual_network_link" "kopi-private-dns-link" {
  name = "kopi-vnet"
  resource_group_name = var.rgn
  private_dns_zone_name = azurerm_private_dns_zone.private-dns.name
  virtual_network_id = var.vnetid
}

# Create a DB Private DNS Zone
resource "azurerm_private_dns_zone" "kopi-endpoint-dns-private-zone" {
  name = "${var.name-dns-privatelink}.database.windows.net"
  resource_group_name = var.rgn
}
