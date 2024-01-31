resource "azurerm_resource_group" "rg" {
  location = "eastus"
  name     = "django_project"
}
resource "azurerm_kubernetes_cluster" "aks" {
  dns_prefix                = "djangoappcluster-dns"
  location                  = "eastus"
  name                      = "djangoappcluster"
  resource_group_name       = azurerm_resource_group.rg.name
  default_node_pool {
    enable_auto_scaling = true
    max_count           = 5
    min_count           = 2
    name                = "agentpool"
    vm_size             = "Standard_DS2_v2"
  }
  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_mssql_server" "db_server" {
  administrator_login = "username"
  administrator_login_password = "pwrd4567gh#"
  location            = "eastus"
  name                = "sqlsvr214"
  resource_group_name = azurerm_resource_group.rg.name
  version             = "12.0"
}


resource "azurerm_mssql_database" "db" {
  name                 = "sql123jkfsdjf23495345"
  server_id            = azurerm_mssql_server.db_server.id
  storage_account_type = "Local"
  depends_on = [
    azurerm_mssql_server.db_server,
  ]
}


resource "azurerm_mssql_firewall_rule" "firewall_rule" {
  end_ip_address   = "0.0.0.0"
  name             = "AllowAllWindowsAzureIps"
  server_id        = azurerm_mssql_server.db_server.id
  start_ip_address = "0.0.0.0"
  depends_on = [
    azurerm_mssql_server.db_server,
  ]
}

