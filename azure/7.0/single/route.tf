resource "azurerm_route_table" "route_table" {
  name                = "internalroutetable"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_route" "default" {
  name                   = "default"
  resource_group_name    = azurerm_resource_group.resource_group.name
  route_table_name       = azurerm_route_table.route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_network_interface.network_interface_2.private_ip_address
}

resource "azurerm_subnet_route_table_association" "subnet_route_table_association" {
  subnet_id      = azurerm_subnet.subnet_private.id
  route_table_id = azurerm_route_table.route_table.id
}
