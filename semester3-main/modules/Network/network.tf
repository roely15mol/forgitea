resource "azurerm_virtual_network" "VN" {
 name                = "vmss-vnet"
 address_space       = ["10.0.0.0/16"]
 location            = var.location
 resource_group_name = var.name
}

resource "azurerm_subnet" "SN" {
 name                 = "vmss-subnet"
 resource_group_name  = var.name
 virtual_network_name = azurerm_virtual_network.VN.name
 address_prefixes       = ["10.0.2.0/24"]
 depends_on = [azurerm_virtual_network.VN]
}

resource "azurerm_public_ip" "IP" {
 name                         = "vmss-public-ip"
 location                     = var.location
 resource_group_name          = var.name
 allocation_method            = "Static"
 domain_name_label            = var.domainprefix
}