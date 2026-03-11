resource "azurerm_lb" "lb" {
  name = var.lb_name
  location = var.rg_location
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name = "PublicIPAddress"
    public_ip_address_id = var.public_ip_id
  }
}

resource "azurerm_lb_backend_address_pool" "node-servers" {
  loadbalancer_id = azurerm_lb.lb.id
  name = var.address_pool_name #"NodeAppAddressPool"
}

resource "azurerm_lb_backend_address_pool_address" "backend_addresses" {
  for_each = var.backends
  name = each.key
  backend_address_pool_id = azurerm_lb_backend_address_pool.node-servers.id
  virtual_network_id = var.vnet_id
  ip_address = each.value
}

resource "azurerm_lb_outbound_rule" "lb_outbound" {
  name = "OutboundRule"
  loadbalancer_id = azurerm_lb.lb.id
  protocol = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.node-servers.id

  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}

resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.lb.id
  name = "app-running-probe"
  port = 5000
}

resource "azurerm_lb_rule" "lb_rule" {
  loadbalancer_id = azurerm_lb.lb.id
  name = "LBRule"
  protocol = "Tcp"
  frontend_port = var.lb_frontend_port
  backend_port = var.lb_backend_port
  frontend_ip_configuration_name = "PublicIPAddress"
  disable_outbound_snat = true

}