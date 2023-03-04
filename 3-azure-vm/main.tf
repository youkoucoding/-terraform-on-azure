terraform {
  required_providers {
    azurerm = {
      source  = "hashcorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vm-rg" {
  name     = "lucas_test_rg"
  location = "Japan East"
  tags = {
    environment = "Dev, Test"
  }
}

resource "azurerm_virtual_network" "vm-virtual-network" {
  name                = "vm-vnet"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = azurerm_resource_group.vm-rg.location
  address_space       = ["10.123.0.0/16"]

  tags = {
    environment = "Dev, Test"
  }
}

resource "azurerm_subnet" "vm-subnet" {
  name                 = "vm-subnet"
  resource_group_name  = azurerm_resource_group.vm-rg.name
  virtual_network_name = azurerm_virtual_network.vm-virtual-network.name
  address_prefixes     = ["10.123.1.0/24"]
}

resource "azurerm_network_security_group" "vm-nsg" {
  name                = "vm-nsg"
  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name

  tags = {
    environment = "Dev, Test"
  }
}

resource "azurerm_network_security_rule" "vm-ns-rule" {
  name                        = "test123"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vm-rg.name
  network_security_group_name = azurerm_network_security_group.vm-nsg.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.vm-subnet.id
  network_security_group_id = azurerm_network_security_group.vm-nsg.id
}

resource "azurerm_public_ip" "vm-public-ip" {
  name                = "vm-ip"
  resource_group_name = azurerm_resource_group.vm-rg.name
  location            = azurerm_resource_group.vm-rg.location
  allocation_method   = "Static"

  tags = {
    environment = "Dev, Test"
  }
}

resource "azurerm_network_interface" "vm-network-interface" {
  name                = "vm-network-interface"
  location            = azurerm_resource_group.vm-rg.location
  resource_group_name = azurerm_resource_group.vm-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.rg-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "Dev, Test"
  }
}



resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "vm-name"
  resource_group_name   = azurerm_resource_group.vm-rg.name
  location              = azurerm_resource_group.vm-rg.location
  size                  = "Standard_F2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.vm-network-interface.id]

  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }
}
