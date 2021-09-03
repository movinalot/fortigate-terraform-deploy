output "curl_command" {
  value = "curl -k -H 'Authorization: Bearer ${random_string.random_apikey.id}' https://${azurerm_public_ip.public_ip.ip_address}/api/v2/cmdb/system/global"
}
