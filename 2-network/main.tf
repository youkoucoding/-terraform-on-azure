terraform {
  require_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  feature {}
}

resource "azurerm_application_insights" "name" {
  resource = 
}
