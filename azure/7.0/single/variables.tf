// Azure configuration

variable "vm_size" {
  type    = string
  default = "Standard_F4"
}

// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "vm_license_type" {
  default = "payg"
}

variable "vm_publisher" {
  type    = string
  default = "fortinet"
}

variable "vm_offer" {
  type    = string
  default = "fortinet_fortigate-vm_v5"
}

// BYOL sku: fortinet_fg-vm
// PAYG sku: fortinet_fg-vm_payg_20190624
variable "vm_sku" {
  type = map(any)
  default = {
    byol = "fortinet_fg-vm"
    payg = "fortinet_fg-vm_payg_20190624"
  }
}

variable "vm_version" {
  type    = string
  default = "6.4.2"
}

variable "vm_username" {
  type    = string
  default = "azureuser"
}

variable "vm_password" {
  type    = string
  default = "Password123!!!"
}

variable "location" {
  type    = string
  default = "eastus2"
}

variable "tag_environment" {
  type    = string
  default = "jmcdonough-fgt-single-api-token"
}

variable "vnetcidr" {
  default = "10.33.0.0/16"
}

variable "external_subnet" {
  default = "10.33.0.0/24"
}

variable "internal_subnet" {
  default = "10.33.1.0/24"
}

variable "vm_config" {
  // Change to your own path
  type    = string
  default = "fgtvm.conf"
}

// license file for the fgt
variable "vm_license_file" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.txt"
}

variable "api_key" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "none"
}
