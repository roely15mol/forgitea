resource "azurerm_lb" "LB" {
 name                = var.name
 location            = var.location
 resource_group_name = var.rgn

 frontend_ip_configuration {
   name                 = "PublicIPAddress"
   public_ip_address_id = var.ip
 }

}

resource "azurerm_lb_backend_address_pool" "BAP" {
 loadbalancer_id     = azurerm_lb.LB.id
 name                = "BackEndAddressPool"
 depends_on = [azurerm_lb.LB]
}

resource "azurerm_lb_probe" "LBP" {
 resource_group_name = var.rgn
 loadbalancer_id     = azurerm_lb.LB.id
 name                = "healthcheck"
 port                = var.application_port
 depends_on = [azurerm_lb.LB]
}

resource "azurerm_lb_rule" "lbrule" {
   resource_group_name            = var.rgn
   loadbalancer_id                = azurerm_lb.LB.id
   name                           = "http"
   protocol                       = "Tcp"
   frontend_port                  = var.application_port
   backend_port                   = var.application_port
   backend_address_pool_id        = azurerm_lb_backend_address_pool.BAP.id
   frontend_ip_configuration_name = "PublicIPAddress"
   probe_id                       = azurerm_lb_probe.LBP.id
   depends_on = [azurerm_lb_probe.LBP]
}