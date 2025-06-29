output "vm_name" {
  description = "Name of the VM"
  value       = oci_core_instance.fndr_sensor.display_name
}

output "public_ip" {
  description = "Public IP address of the VM"
  value       = oci_core_instance.fndr_sensor.public_ip
}

output "private_ip" {
  description = "Private IP address of the VM"
  value       = oci_core_instance.fndr_sensor.private_ip
}

output "sniffer_private_ip" {
  description = "Private IP address of the sniffer interface"
  value       = data.oci_core_vnic.sniffer_vnic.private_ip_address
}

output "username" {
  description = "Default username"
  value       = "Admin"
}

output "password" {
  description = "Password (VM OCID)"
  value       = oci_core_instance.fndr_sensor.id
  sensitive   = true
}

output "vm_ocid" {
  description = "OCID of the VM"
  value       = oci_core_instance.fndr_sensor.id
}

# Data source to get sniffer VNIC details
data "oci_core_vnic" "sniffer_vnic" {
  vnic_id = oci_core_vnic_attachment.fndr_sniffer_vnic.vnic_id
}
