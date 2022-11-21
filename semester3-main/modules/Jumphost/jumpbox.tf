resource "azurerm_public_ip" "jumpbox" {
 name                         = var.name
 location                     = var.location
 resource_group_name          = var.rgn
 allocation_method            = "Static"
 domain_name_label            = "${var.domainprefix}-ssh"
}

resource "azurerm_network_interface" "jumpbox" {
 name                = "jumpbox-nic"
 location            = var.location
 resource_group_name = var.rgn

 ip_configuration {
   name                          = "IPConfiguration"
   subnet_id                     = var.subnet
   private_ip_address_allocation = "dynamic"
   public_ip_address_id          = azurerm_public_ip.jumpbox.id
 }
 depends_on = [azurerm_public_ip.jumpbox]

}

resource "azurerm_virtual_machine" "jumpbox" {
 name                  = var.jumpboxname
 location              = var.location
 resource_group_name   = var.rgn
 network_interface_ids = [azurerm_network_interface.jumpbox.id]
 vm_size               = "Standard_B1s"
 depends_on = [azurerm_network_interface.jumpbox]

 storage_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "18.04-LTS"
   version   = "latest"
 }

 storage_os_disk {
   name              = "${var.cn}-osdisk"
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 os_profile {
   computer_name  = var.cn
   admin_username = var.admin_user
   admin_password = var.admin_password
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }
}