resource "azurerm_network_interface" "main" {
  name                = "${var.application_type}-${var.resource_type}-nic"
  location            = var.location
  resource_group_name = var.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_address_id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                = "${var.application_type}-${var.resource_type}"
  location            = var.location
  resource_group_name = var.resource_group
  size                = "Standard_B1s"
  admin_username      = var.vm_admin_username
  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDlviFcw23L6lccXK+fvOi2EV2xAm8e2YjyhwbZCEgrlunYe4Nj39+3nHpus/+yPAKNXrqIadpdDipKrWdDmJx6LGIG7Igjo353tbjWAm9mbbHvn+HtvimPSWodJPVrxQBOQGZwfr26RGQWwhg6LD9zM6zUn8vEAyuktQDZMY/kHVDz2oWGr05Dv8MPo6Wjh5dh/rQtQXOtCO0EVQxXumo516dwfRUWvMYy9xdBGTGnlH59P6VRoI9fb4Y5LpTgx2ZhTlobcpI/mhAkybWnPDfUkVg5ORKkL9nNKxfN49UKxWAt5leC+yuNNlLbTNBwJV59nNMRB8D7XUpo5Uz6Jq7PVhA4KzL2DXpyIpssK36CTdMADtx7chyTa05ypa1BPJmHaHJw3iCbjMQaR3Rx2LZCoKnnXJrBS2+aFxZL68sk0u9C2AE/6cdpvcFPynw4HdlRs9u0Giumdjekw5mw5oPYCrYaCrQZVvja6PV+lcARTpHSu3ZduhQ5slos3OzKha8= Pemberai@DESKTOP-RLH17JE"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  tags = {
    environment = "TEST"
  }
}
