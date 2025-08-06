data "azurerm_resource_group" "main" {
  name = "1-18d74096-playground-sandbox"
}

resource "azurerm_service_plan" "main" {
  name                = "sandbox-terraformed-asp"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "main" {
  name                = "sandbox-terraformed-app"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  service_plan_id     = azurerm_service_plan.main.id

  site_config {
    application_stack {
      docker_image_name = "corndeldevopscourse/mod12app:latest"
    }
  }

  app_settings = {
    "DEPLOYMENT_METHOD" = "Terraform"
    "CONNECTION_STRING" = "Server=tcp:${azurerm_mssql_server.main.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_server.main.name};Persist Security Info=False;User ID=${azurerm_mssql_server.main.administrator_login};Password=${random_password.db_password.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  }
}

resource "azurerm_mssql_server" "main" {
  name                         = "sandbox-non-iac-sqlserver"
  resource_group_name          = data.azurerm_resource_group.main.name
  location                     = data.azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = "dbadmin"
  administrator_login_password = random_password.db_password.result
}

resource "azurerm_mssql_database" "main" {
  name         = "sandbox-non-iac-db"
  server_id    = azurerm_mssql_server.main.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb  = 2
  sku_name     = "Basic"

  lifecycle {
    prevent_destroy = true
  }
}

resource "random_password" "db_password" {
  length           = 32
  min_lower        = 1
  min_numeric      = 1
  min_upper        = 1
  min_special      = 1
  override_special = "_%!"
}

output "password" {
  value = nonsensitive(random_password.db_password.result)
  sensitive = true
}
