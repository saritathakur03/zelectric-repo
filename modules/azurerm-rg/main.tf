resource "azurerm_resource_group" "dev-vm-rg-centralindia" {
  for_each = var.rg_map
  name     = each.value.name
  location = each.value.location
}
