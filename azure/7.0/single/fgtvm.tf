resource "azurerm_virtual_machine" "virtual_machine" {
  name                         = "fortigate"
  location                     = azurerm_resource_group.resource_group.location
  resource_group_name          = azurerm_resource_group.resource_group.name
  network_interface_ids        = [azurerm_network_interface.network_interface_1.id, azurerm_network_interface.network_interface_2.id]
  primary_network_interface_id = azurerm_network_interface.network_interface_1.id
  vm_size                      = var.vm_size

  identity {
    type = "SystemAssigned"
  }
  storage_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_license_type == "byol" ? var.vm_sku["byol"] : var.vm_sku["payg"]
    version   = var.vm_version
  }

  plan {
    name      = var.vm_license_type == "byol" ? var.vm_sku["byol"] : var.vm_sku["payg"]
    publisher = var.vm_publisher
    product   = var.vm_offer
  }

  storage_os_disk {
    name              = "osDisk"
    caching           = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    create_option     = "FromImage"
  }

  # Log data disks
  storage_data_disk {
    name              = "fgtvmdatadisk"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }

  os_profile {
    computer_name  = "fortigate"
    admin_username = var.vm_username
    admin_password = var.vm_password
    custom_data    = data.template_file.fgtvm.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.storage_account.primary_blob_endpoint
  }
}

data "template_file" "fgtvm" {
  template = file(var.vm_config)
  vars = {
    type         = var.vm_license_type
    license_file = var.vm_license_file
    api_key      = random_string.apikey.id
  }
}
