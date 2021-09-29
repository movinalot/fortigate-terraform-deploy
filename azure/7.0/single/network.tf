// Create Virtual Network

resource "azurerm_virtual_network" "virtual_network" {
  name                = "fgtvnetwork"
  address_space       = [var.vnetcidr]
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group.name
}

resource "azurerm_subnet" "subnet_public" {
  name                 = "external"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.external_subnet]
}

resource "azurerm_subnet" "subnet_private" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = [var.internal_subnet]
}


// Allocated Public IP
resource "azurerm_public_ip" "public_ip" {
  name                = "fgt-public-ip"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
}

//  Network Security Group
resource "azurerm_network_security_group" "security_group_public" {
  name                = "externalNetworkSecurityGroup"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "TCP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "security_group_private" {
  name                = "internalNetworkSecurityGroup"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "All"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_rule" "security_rule_public" {
  name                        = "egress"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.security_group_public.name
}

resource "azurerm_network_security_rule" "security_rule_private" {
  name                        = "egress-private"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.security_group_private.name
}

// FGT Network Interface port1
resource "azurerm_network_interface" "network_interface_1" {
  name                = "fgtport1"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet_public.id
    private_ip_address_allocation = "Dynamic"
    primary                       = true
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface" "network_interface_2" {
  name                 = "fgtport2"
  location             = azurerm_resource_group.resource_group.location
  resource_group_name  = azurerm_resource_group.resource_group.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet_private.id
    private_ip_address_allocation = "Dynamic"
  }
}
# Connect the security group to the network interfaces
resource "azurerm_network_interface_security_group_association" "security_group_association_port1" {
  network_interface_id      = azurerm_network_interface.network_interface_1.id
  network_security_group_id = azurerm_network_security_group.security_group_public.id
}

resource "azurerm_network_interface_security_group_association" "security_group_association_port2" {
  network_interface_id      = azurerm_network_interface.network_interface_2.id
  network_security_group_id = azurerm_network_security_group.security_group_private.id
}

