terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "storageterraformjj"
    container_name       = "bank-infra"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "global" {
  source   = "./modules/global"
  location = var.location
}

module "containers" {
  source              = "./modules/containers"
  location            = var.location
  resource_group_name = module.global.bank_resource_group_name
}
