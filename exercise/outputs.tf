output "password" {
  value     = nonsensitive(random_password.db_password.result)
  sensitive = true
}

output "webapp_hostname" {
  value = azurerm_linux_web_app.main.default_hostname
}
