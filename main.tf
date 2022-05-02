terraform {
  backend "azurerm" {
  }
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "this" {
  name     = "rg-fb-20220502"
  location = "westeurope"
}

resource "azurerm_virtual_network" "this" {
  # for_each            = { for v in local.vnets : v.key => v }
  for_each            = var.vnets
  name                = "vnet-${each.key}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  address_space       = each.value.address_space
}

resource "azurerm_subnet" "this" {
  for_each             = { for s in local.subnets : "${s.vnet_ref}-${s.snet_key}" => s }
  name                 = "snet-${each.key}"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this["${each.value.vnet_ref}"].name
  address_prefixes     = each.value.address_prefixes
}