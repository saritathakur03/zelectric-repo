
resource "azurerm_public_ip" "dev-vm-pip-centralindia" {
  for_each            = var.vms
  name                = "${each.value.vm_name}-dev-vm-pip-centralindia"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "dev-vm-nsg-centralindia" {
  for_each            = var.vms
  name                = "${each.value.vm_name}-dev-vm-nsg-centralindia"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name


  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_interface" "dev-vm-nic-centralindia" {
  for_each            = var.vms
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "test-ipconfigration"
    subnet_id                     = data.azurerm_subnet.dev-vm-snet-data[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.dev-vm-pip-centralindia[each.key].id
  }
}

resource "azurerm_network_interface_security_group_association" "nicnsgassoc" {
  for_each                  = var.vms
  network_interface_id      = azurerm_network_interface.dev-vm-nic-centralindia[each.key].id
  network_security_group_id = azurerm_network_security_group.dev-vm-nsg-centralindia[each.key].id
}


resource "azurerm_linux_virtual_machine" "dev-vm-virtual_machine-centralindia" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = "adminuser"
  admin_password                  = "passw@rd123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.dev-vm-nic-centralindia[each.key].id]




  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

