//outputs Access Key to other modules
output "StorageAccountKey" {
  value = azurerm_storage_account.storageaccount.primary_access_key
  sensitive = true
}