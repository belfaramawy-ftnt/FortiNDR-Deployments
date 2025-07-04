# Local Authentication
region = "me-riyadh-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaambr3uzztoyhweohbzqqdo775h7d3t54zpmzkp4b2cf35vs55ck3a"
compartment_ocid = "ocid1.compartment.oc1..aaaaaaaaefwplsi4eu2xqlwnwkg4eise64nu7qwjhswgwf7qxpajkkdroi6a"

# Remote Authentication

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
mgmt_private_ip = "10.99.70.100"
sniffer_private_ip = "10.99.75.100"

# VM Configuration
vm_image_ocid = "https://objectstorage.me-riyadh-1.oraclecloud.com/p/5YSMpgiEn1rMTAtElPlU7waJCLQfb2vp1RdsYTVvjqFDLir4T3oAi99482ioRLOf/n/fortinetoraclecloud1/b/fndr-762/o/NDR-Sensor-762-image"
instance_shape = "VM.Standard3.Flex"
instance_ocpus = 32
instance_memory_in_gbs = 128
