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
