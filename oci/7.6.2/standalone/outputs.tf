output "a_deployment_notice" {
  description = "Important deployment information"
  value       = "⚠️  WAIT 2-3 minutes after deployment completes, then access FortiNDR UI at: https://${oci_core_public_ip.mgmt_ip.ip_address}"
}

output "b_vm_name" {
  description = "Name of the VM"
  value       = oci_core_instance.fndr_sensor.display_name
}

output "c_username" {
  description = "Default username"
  value       = "Admin"
}

output "d_password" {
  description = "Password (VM OCID)"
  value       = oci_core_instance.fndr_sensor.id
}

output "e_mgmt_public_ip" {
  description = "Public IP address of the VM"
  value       = oci_core_instance.fndr_sensor.public_ip
}

output "f_mgmt_private_ip" {
  description = "Private IP address of the VM"
  value       = oci_core_instance.fndr_sensor.private_ip
}

output "g_sniffer_private_ip" {
  description = "Private IP address of the sniffer interface"
  value       = data.oci_core_vnic.sniffer_vnic.private_ip_address
}

# Data source to get sniffer VNIC details
data "oci_core_vnic" "sniffer_vnic" {
  vnic_id = oci_core_vnic_attachment.fndr_sniffer_vnic.vnic_id
}
