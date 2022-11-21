resource "azurerm_mysql_server" "SQLSVR" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rgn

  administrator_login          = var.mysql_admin_user
  administrator_login_password = var.mysql_admin_password
  sku_name                     = "B_Gen5_1" 
  storage_mb                   = 5120       
  version                      = "5.7"

  auto_grow_enabled                = true
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  public_network_access_enabled    = true                     # Nog Aanpassen
  ssl_enforcement_enabled          = false                    
  ssl_minimal_tls_version_enforced = "TLSEnforcementDisabled" 
}

resource "azurerm_mysql_database" "SQLDB" {
  name                = var.dbname
  resource_group_name = var.rgn
  server_name         = azurerm_mysql_server.SQLSVR.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
  depends_on = [azurerm_mysql_server.SQLSVR]
}

resource "azurerm_mysql_firewall_rule" "FWR" {
  name                = "public-internet"
  resource_group_name = var.rgn
  server_name         = azurerm_mysql_server.SQLSVR.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
  depends_on = [azurerm_mysql_server.SQLSVR]
}