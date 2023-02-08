terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "app" {
  name     = var.resource_group_name
  location = "East"

  tags = {
    Environment = "Dev AD"
  }
}

resource "azurerm_cdn_frontdoor_profile" "app" {
  name                = "app-redirect"
  resource_group_name = azurerm_resource_group.app.name
}

resource "azurerm_cdn_frontdoor_rule_set" "app" {
  name                     = "app-redirect-rule-set"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.app.id
}

resource "azurerm_cdn_frontdoor_rule" "slackapp" {
  depends_on = [azurerm_cdn_frontdoor_rule_set.app]

  name                      = "rule"
  cdn_frontdoor_rule_set_id = azurerm_cdn_frontdoor_rule_set.app.id
  order                     = 1
  behavior_on_match         = "Continue"

  actions {
    url_redirect_action {
      redirect_type        = "Found"
      redirect_protocol    = "Https"
      destination_path     = ""
      destination_hostname = ""
    }
  }

  conditions {
    host_name_condition {
      operator         = "Equal"
      negate_condition = false
      match_values     = ["www.contoso.com", "images.contoso.com", "video.contoso.com"]
      transforms       = ["Lowercase", "Trim"]
    }
  }
}
