data "azurerm_subnet" "dev-vm-snet-data" {
  for_each             = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

# data "azurerm_key_vault" "dev-vm-key_vault" {
#   name                = "vm-keyvault-password"
#   resource_group_name = "sarita-rg1"
# }

# data "azurerm_key_vault_secret" "dev-vm-secret-username" {
#   name         = "vm-username"
#   key_vault_id = data.azurerm_key_vault.dev-vm-key_vault.id
# }

# data "azurerm_key_vault_secret" "dev-vm-secret-password" {
#   name         = "vm-password"
#   key_vault_id = data.azurerm_key_vault.dev-vm-key_vault.id
# }
