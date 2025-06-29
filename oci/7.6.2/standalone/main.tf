terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "~> 4.0"
    }
  }
}

provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  # user_ocid        = var.user_ocid
  # fingerprint      = var.fingerprint
  # private_key_path = var.private_key_path
  region          = var.region
}

# Get availability domain
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}

locals {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[var.availability_domain - 1].name
}

# Create VCN
resource "oci_core_vcn" "fndr_vcn" {
  cidr_block     = var.vcn_cidr
  compartment_id = var.compartment_ocid
  display_name   = var.vcn_name
}

# Create Internet Gateway
resource "oci_core_internet_gateway" "fndr_igw" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.fndr_vcn.id
  display_name   = "${var.vcn_name}-igw"
}

# Create NAT Gateway
resource "oci_core_nat_gateway" "fndr_nat" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.fndr_vcn.id
  display_name   = "${var.vcn_name}-nat"
}

# Create Security List for Management (allows all traffic)
resource "oci_core_security_list" "fndr_mgmt_seclist" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.fndr_vcn.id
  display_name   = "${var.vcn_name}-mgmt-seclist"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "all"
  }
}

# Create Security List for Sniffer (allows all traffic)
resource "oci_core_security_list" "fndr_sniffer_seclist" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.fndr_vcn.id
  display_name   = "${var.vcn_name}-sniffer-seclist"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "all"
  }
}

# Create Route Table for Public Subnet
resource "oci_core_route_table" "fndr_public_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.fndr_vcn.id
  display_name   = "${var.vcn_name}-public-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.fndr_igw.id
  }
}

# Create Route Table for Private Subnet
resource "oci_core_route_table" "fndr_private_rt" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.fndr_vcn.id
  display_name   = "${var.vcn_name}-private-rt"

  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.fndr_nat.id
  }
}

# Create Public Subnet for Management
resource "oci_core_subnet" "fndr_mgmt_subnet" {
  availability_domain = local.availability_domain
  cidr_block          = var.mgmt_subnet_cidr
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.fndr_vcn.id
  display_name        = var.mgmt_subnet_name
  security_list_ids   = [oci_core_security_list.fndr_mgmt_seclist.id]
  route_table_id      = oci_core_route_table.fndr_public_rt.id
  prohibit_public_ip_on_vnic = false
}

# Create Private Subnet for Sniffer
resource "oci_core_subnet" "fndr_sniffer_subnet" {
  availability_domain = local.availability_domain
  cidr_block          = var.sniffer_subnet_cidr
  compartment_id      = var.compartment_ocid
  vcn_id              = oci_core_vcn.fndr_vcn.id
  display_name        = var.sniffer_subnet_name
  security_list_ids   = [oci_core_security_list.fndr_sniffer_seclist.id]
  route_table_id      = oci_core_route_table.fndr_private_rt.id
  prohibit_public_ip_on_vnic = true
}

# Create FNDR Sensor Instance
resource "oci_core_instance" "fndr_sensor" {
  availability_domain = local.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = var.vm_name
  shape               = var.instance_shape
  shape_config {
    ocpus         = var.instance_ocpus
    memory_in_gbs = var.instance_memory_in_gbs
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.fndr_mgmt_subnet.id
    display_name           = "${var.vm_name}-mgmt-vnic"
    assign_public_ip       = false
  }

  source_details {
    source_type = "image"
    source_id   = var.vm_image_ocid
    boot_volume_size_in_gbs = 50
  }

  metadata = {
    ssh_authorized_keys = ""
  }
}

# Create secondary VNIC for sniffer
resource "oci_core_vnic_attachment" "fndr_sniffer_vnic" {
  instance_id = oci_core_instance.fndr_sensor.id
  
  create_vnic_details {
    subnet_id        = oci_core_subnet.fndr_sniffer_subnet.id
    display_name     = "${var.vm_name}-sniffer-vnic"
    assign_public_ip = false
  }
}

# Create additional data volume
resource "oci_core_volume" "fndr_data_volume" {
  availability_domain = local.availability_domain
  compartment_id      = var.compartment_ocid
  display_name        = "${var.vm_name}-data-volume"
  size_in_gbs         = var.data_disk_size
  vpus_per_gb         = 10
}

# Attach data volume to instance
resource "oci_core_volume_attachment" "fndr_data_attachment" {
  attachment_type = "paravirtualized"
  instance_id     = oci_core_instance.fndr_sensor.id
  volume_id       = oci_core_volume.fndr_data_volume.id
  display_name    = "${var.vm_name}-data-attachment"
}

# Lookup the primary private IP of the MGMT VNIC
data "oci_core_private_ips" "mgmt_private_ips" {
  ip_address = oci_core_instance.fndr_sensor.private_ip
  subnet_id  = oci_core_subnet.fndr_mgmt_subnet.id
}

# Reserve Public IP for MGMT VNIC
resource "oci_core_public_ip" "mgmt_ip" {
  compartment_id = var.compartment_ocid
  display_name   = "${var.vm_name}-public-ip"
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.mgmt_private_ips.private_ips[0].id
}
