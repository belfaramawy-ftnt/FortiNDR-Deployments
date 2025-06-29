# OCI Authentication
region = "me-riyadh-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaambr3uzztoyhweohbzqqdo775h7d3t54zpmzkp4b2cf35vs55ck3a"
compartment_ocid = "ocid1.compartment.oc1..aaaaaaaaefwplsi4eu2xqlwnwkg4eise64nu7qwjhswgwf7qxpajkkdroi6a"
# user_ocid = "ocid1.user.oc1..aaaaaaaaxxxxx"
# fingerprint = "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
# private_key_path = "~/.oci/oci_api_key.pem"

# Resource Names
vm_name = "fndr-standalone-01"
vcn_name = "fndr-vcn"
mgmt_subnet_name = "fndr-mgmt-subnet"
sniffer_subnet_name = "fndr-sniffer-subnet"

# Network Configuration
vcn_cidr = "10.99.0.0/16"
mgmt_subnet_cidr = "10.99.70.0/24"
sniffer_subnet_cidr = "10.99.75.0/24"

# VM Configuration
vm_image_ocid = "ocid1.image.oc1.me-riyadh-1.aaaaaaaanehepwi7bmfemebw6udyomhjy5rvcgbn6de4bgb6no44odtqv75a"
instance_shape = "VM.Standard2.4"
