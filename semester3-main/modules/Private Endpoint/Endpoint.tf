# Create a DB Private Endpoint
resource "azurerm_private_endpoint" "db-endpoint" {
  name = var.name
  location = var.location
  resource_group_name = var.rgn
  subnet_id = var.subnet
  private_service_connection {
    name = var.privateconnection
    is_manual_connection = "false"
    private_connection_resource_id = var.sqlid
    subresource_names = ["sqlServer"]
  }
}

# DB Private Endpoint Connecton
data "azurerm_private_endpoint_connection" "db-endpoint-connection" {
  depends_on = [azurerm_private_endpoint.db-endpoint]
  name = azurerm_private_endpoint.db-endpoint.name
  resource_group_name = var.rgn
}

# Create a DB Private DNS A Record
resource "azurerm_private_dns_a_record" "kopi-endpoint-dns-a-record" {
  name = lower(var.sqlsvrname)
  zone_name = var.privatednszonename
  resource_group_name = var.rgn
  ttl = 300
  records = [data.azurerm_private_endpoint_connection.db-endpoint-connection.private_service_connection.0.private_ip_address]
}

# Create a Private DNS to VNET link
resource "azurerm_private_dns_zone_virtual_network_link" "dns-zone-to-vnet-link" {
  name = "kopi-sql-db-vnet-link"
  resource_group_name = var.rgn
  private_dns_zone_name = var.privatednszonename
  virtual_network_id = var.vnetid
}
