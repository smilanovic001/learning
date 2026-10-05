terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0" # Nutzt die modernen Version-4-Spezifikationen
    }
  }
}

provider "azurerm" {
  features {}
}

# 1. Erstellen der Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-helloworld-dev"
  location = "germany"
}

# 2. Erstellen der Azure Static Web App
resource "azurerm_static_web_app" "swa" {
  name                = "swa-helloworld-dev"
  resource_group_name = "azurerm_resource_group.rg.name"
  location            = "azurerm_resource_group.rg.location"
  
  # 'Free' garantiert 0,00 € Kosten für diese statische Seite
  sku_tier            = "Free"
  sku_size            = "Free"
}
/*
# 3. Aufschalten der Custom Domain (Erzeugt automatisch das SSL-Zertifikat)
resource "azurerm_static_web_app_custom_domain" "domain" {
  static_web_app_id = azurerm_static_web_app.swa.id
  domain_name       = "www.ihre-wunschdomain.de" # Ersetzen Sie dies mit Ihrer Domain
  validation_type   = "cname-delegation"
}
*/
# Ausgabe der standardmäßig generierten Azure-URL nach dem Deployment
output "static_web_app_default_host_name" {
  value       = azurerm_static_web_app.swa.default_host_name
  description = "Die von Azure automatisch generierte HTTPS-Adresse der Webseite."
}