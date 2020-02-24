variable "tenancy_ocid" {}
variable "OCITerra_compartment_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "region" {}
variable "ssh_authorized_key" {}

variable "selected_ad" {
  type = map(number)
  default = {
    dev  = 1
    uat  = 2
    prod = 3
  }
}

variable "vnc_cidr_range" {
  type = map(string)
  default = { // "."0.0/16" will be appended
    dev  = "10.10"
    uat  = "10.11"
    prod = "10.12"
  }
}

variable "instance_shape" {
  type = map(string)
  default = {
    prod = "VM.Standard2.1"
  }
}

variable "available_images" {
  // Look up the OCIDs here: https://docs.cloud.oracle.com/iaas/images
  type = map(string)
  default = {
    v3  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaavys65jtyd7heqszd56zrz5cqmj3dcya3gsjuh35hdd73bacvk45a" // CentOS-7-2020.01.27-0
    v2  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaawejnjwwnzapqukqudpczm4pwtpcsjhohl7qcqa5vzd3gxwmqiq3q" // CentOS-7-2019.08.26-0
    v1  = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaagh4hrb2wnpomtl24z42qz3vsgkaz4v3qzqmlssd6q4x3wvai3kha" // CentOS-7-2019.04.15-0
  }
}

variable "selected_image" {
  type = map(string)
  default = {
    dev  = "v2"
    uat  = "v1"
    prod = "v1"
  }
}
