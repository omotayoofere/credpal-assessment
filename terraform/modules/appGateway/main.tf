resource "azurerm_application_gateway" "app_gateway" {
  name = var.app_gateway_name
  location = var.rg_region
  resource_group_name = var.rg_name

  identity {
    type = "UserAssigned"
    identity_ids = var.app_gateway_user_assigned_id
  }

  sku {
    name = var.sku_name #"Standard_v2"
    tier = var.sku_tier #"Standard_v2"
    capacity = var.instance_count
  }

  gateway_ip_configuration {
    name = local.gateway_ip_configuration_name
    subnet_id = var.gateway_subnet_id
  }

  frontend_port {
    name = local.frontend_port_name
    port = var.frontend_port
  }

  frontend_ip_configuration {
    name = local.frontend_ip_configuration_name
    public_ip_address_id = var.frontend_ip_addr
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name = local.http_setting_name
    cookie_based_affinity = "Disabled"
    port = 80
    protocol = "Http"
    request_timeout = 1
  }

  ssl_certificate {
    name = var.ssl_certificate_name #"gateway-cert"
    key_vault_secret_id = var.appgw_cert_secret_id
  }

  http_listener {
    name = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name = local.frontend_port_name
    protocol = "Https"
    ssl_certificate_name = var.ssl_certificate_name
  }

  request_routing_rule {
    name = local.request_routing_rule_name
    rule_type = "Basic"
    priority = 25
    http_listener_name = local.listener_name
    backend_address_pool_name = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "gateway_nic_conn" {
  for_each = var.backends

  network_interface_id = each.value
  ip_configuration_name = "${each.key}-ip-config"
  backend_address_pool_id = tolist(azurerm_application_gateway.app_gateway.backend_address_pool).0.id
}