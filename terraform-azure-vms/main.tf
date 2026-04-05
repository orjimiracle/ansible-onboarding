
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = var.location
  depends_on = [ azurerm_resource_group.example ]
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]


  tags = {
    environment = "Ansible"
  }
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "example" {
  name                = "ansibledemo-nsg"
  location            = var.location
  depends_on = [ azurerm_resource_group.example ]
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-http"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Ansible"
  }
}

# Public IPs
resource "azurerm_public_ip" "pip" {
  for_each            = toset(var.vm_roles)
  name                = "${each.value}-pip"
  location            = var.location
  depends_on = [ azurerm_resource_group.example ]
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"    # ← change Dynamic to Static
  sku                 = "Standard"  # ← add this line
}

resource "azurerm_network_interface" "nic" {
  for_each            = toset(var.vm_roles)
  name                = "${each.value}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id =  azurerm_public_ip.pip[each.value].id
  }
}

resource "azurerm_network_interface_security_group_association" "ngsoc" {
  for_each = toset(var.vm_roles)
  network_interface_id      = azurerm_network_interface.nic[each.value].id
  network_security_group_id = azurerm_network_security_group.example.id
}


# Linux VMs
resource "azurerm_linux_virtual_machine" "main" {
  for_each               = toset(var.vm_roles)
  name                = each.value
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_user
  network_interface_ids = [azurerm_network_interface.nic[each.value].id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_user
    public_key = file(var.ssh_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
