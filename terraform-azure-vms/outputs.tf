output "vm_ssh_commands" {
  description = "SSH commands for public VMs only"
  value = {
    for role, pip in azurerm_public_ip.pip :
    role => "ssh ${var.admin_user}@${pip.ip_address}"
  }
}
