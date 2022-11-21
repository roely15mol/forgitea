output "StorageAccountName" {
    value = azurerm_storage_account.SACC.name
}

output "sak" {
    value = azurerm_storage_account.SACC.primary_access_key
}

output "fsn" {
    value = azurerm_storage_share.SHARE.name
}