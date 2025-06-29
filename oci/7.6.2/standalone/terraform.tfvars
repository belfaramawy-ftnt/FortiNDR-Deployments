# OCI Authentication
region = "us-ashburn-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxxxxx"
user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxx"
fingerprint = "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
private_key_path = "~/.oci/oci_api_key.pem"
compartment_ocid = "ocid1.compartment.oc1..aaaaaaaaxxxxx"

# Resource Names
vm_name = "fndr-sensor-01"
vcn_name = "fndr-vcn"
mgmt_subnet_name = "fndr-mgmt-subnet"
sniffer_subnet_name = "fndr-sniffer-subnet"

# Network Configuration
vcn_cidr = "10.0.0.0/16"
mgmt_subnet_cidr = "10.0.1.0/24"
sniffer_subnet_cidr = "10.0.2.0/24"

# VM Configuration
vm_image_ocid = "ocid1.image.oc1.us-ashburn-1.aaaaaaaaxxxxx"
instance_shape = "VM.Standard2.4"
