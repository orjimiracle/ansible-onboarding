variable "location" {
  description = "location of the resource"
    type        = string
    default = "centralindia"
}

variable "resource_group_name" {
  description = "This is the name of the resource group"
  type = string
  default = "rg-ansible-lab"
}

variable "vm_size" {
  default = "Standard_B2ts_v2"
}

variable "admin_user" {
  default = "azureuser"
}

variable "ssh_public_key_path" {
  default = "~/.ssh/azure_rsa.pub"
}

variable "vm_roles" {
  default = ["web1", "app1"]
}
