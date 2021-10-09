resource "azurerm_resource_group" "bank_rg" {
  name     = "bank-rg"
  location = var.location
}
