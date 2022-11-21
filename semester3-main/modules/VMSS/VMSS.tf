resource "azurerm_virtual_machine_scale_set" "VMSS" {
 name                = var.name
 location            = var.location
 resource_group_name = var.rgn
 upgrade_policy_mode = "Manual"

 sku {
   name     = "Standard_B2s"
   tier     = "Standard"
   capacity = 2
 }

 storage_profile_image_reference {
   publisher = "Canonical"
   offer     = "UbuntuServer"
   sku       = "18.04-LTS"
   version   = "latest"
 }

 storage_profile_os_disk {
   name              = ""
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }

 os_profile {
  computer_name_prefix = var.computernameprefix
  admin_username       = var.admin_user
  admin_password       = var.admin_password
  custom_data          = data.template_file.userdata.rendered
 }

 os_profile_linux_config {
   disable_password_authentication = false
 }

 network_profile {
   name    = var.networkprofilename
   primary = true

   ip_configuration {
     name                                   = "IPConfiguration"
     subnet_id                              = var.subnet
     load_balancer_backend_address_pool_ids = [var.lbbe]
     primary = true
   }
 }

}

