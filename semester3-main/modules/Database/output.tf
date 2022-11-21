output "dbusername" {
    value = var.mysql_admin_user
}

output "dbpassword" {
    value = var.mysql_admin_password
}

output "dbnaam" {
    value = azurerm_mysql_database.SQLDB.name
}

output "dbadres" {
    value = azurerm_mysql_server.SQLSVR.fqdn
}

