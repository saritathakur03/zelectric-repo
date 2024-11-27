module "rg_block" {
  source = "../../modules/azurerm-rg"
  rg_map = var.rg_map
}

module "vnet_block" {
  depends_on = [module.rg_block]
  source     = "../../modules/azurerm-vnets"
  vnet       = var.vnet_map
}

module "snet_block" {
  depends_on = [module.vnet_block]
  source     = "../../modules/azurem-subnets"
  snet       = var.snet_map
}

module "vm_block" {
  depends_on = [module.snet_block]
  source     = "../../modules/azurerm-vm"
  vms        = var.vms_map
}
