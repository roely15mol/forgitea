resource "azurerm_storage_account" "SACC" {
  name                     = var.storageaccount
  resource_group_name      = var.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

}

resource "azurerm_storage_share" "SHARE" {
  name                 = var.sharename
  storage_account_name = azurerm_storage_account.SACC.name
  quota                = 50
  depends_on = [azurerm_storage_account.SACC]

}
