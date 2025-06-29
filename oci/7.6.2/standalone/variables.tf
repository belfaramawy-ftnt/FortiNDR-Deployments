variable "region" {
  description = "OCI Region"
  type        = string
}

variable "tenancy_ocid" {
  description = "Tenancy OCID"
  type        = string
}

variable "user_ocid" {
  description = "User OCID"
  type        = string
}

variable "fingerprint" {
  description = "Key fingerprint"
  type        = string
}

variable "private_key_path" {
  description = "Path to private key"
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "vcn_name" {
  description = "Name of the VCN"
  type        = string
}

variable "mgmt_subnet_name" {
  description = "Name of the management subnet"
  type        = string
}

variable "sniffer_subnet_name" {
  description = "Name of the sniffer subnet"
  type        = string
}

variable "vcn_cidr" {
  description = "CIDR block for VCN"
  type        = string
}

variable "mgmt_subnet_cidr" {
  description = "CIDR block for management subnet"
  type        = string
}

variable "sniffer_subnet_cidr" {
  description = "CIDR block for sniffer subnet"
  type        = string
}

variable "vm_image_ocid" {
  description = "OCID of the VM image"
  type        = string
}

variable "instance_shape" {
  description = "Instance shape"
  type        = string
  default     = "VM.Standard2.4"
}

variable "availability_domain" {
  description = "Availability domain"
  type        = string
  default     = "1"
}

variable "ndr_license" {
  description = "Path to NDR license file"
  type        = string
  default     = "./license/ndrlicenseexample.lic"
}

variable "data_disk_size" {
  description = "Size of data disk in GB"
  type        = number
  default     = 1024
