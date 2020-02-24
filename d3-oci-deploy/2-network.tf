// create a demo_vcn inside the demo_compartment
// look up the cidr_range from vnc_cidr_range based on the terraform workspace
resource "oci_core_vcn" "demo_vcn" {
  cidr_block     = "${lookup(var.vnc_cidr_range, terraform.workspace)}.0.0/16"
  compartment_id = oci_identity_compartment.demo_compartment.id
  display_name   = "demo-${terraform.workspace}-vcn"
}

// create a security_list in the demo_vcn, that allows 
//   - all outgoing TCP traffic 
//   - incoming TCP traffic on ports 22 and 80
resource "oci_core_security_list" "demo_sl" {
  compartment_id = oci_identity_compartment.demo_compartment.id
  display_name   = "demo-${terraform.workspace}-security_list"
  vcn_id         = oci_core_vcn.demo_vcn.id
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "6" // tcp
  }
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false
    tcp_options {
      min = 22
      max = 22
    }
  }
  ingress_security_rules {
    protocol  = "6" // tcp
    source    = "0.0.0.0/0"
    stateless = false
    tcp_options {
      min = 80
      max = 80
    }
  }
}

// We also require an internet gateway in demo_vnc to support traffic to and from internet
resource "oci_core_internet_gateway" "demo_igw" {
  #Required
  compartment_id = oci_identity_compartment.demo_compartment.id
  display_name   = "demo-${terraform.workspace}-igw"
  vcn_id         = oci_core_vcn.demo_vcn.id
}

// adding the routing table tp demo_vcn that uses the internet gateway
resource "oci_core_route_table" "demo_rt" {
  compartment_id = oci_identity_compartment.demo_compartment.id
  display_name   = "demo-${terraform.workspace}-rt"
  vcn_id         = oci_core_vcn.demo_vcn.id
  route_rules {
    network_entity_id = oci_core_internet_gateway.demo_igw.id
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }
}

// retrieve information about the chosen availability domain in demo_compartment compartment
data "oci_identity_availability_domain" "demo_ad" {
  compartment_id = oci_identity_compartment.demo_compartment.id
  ad_number      = "${lookup(var.selected_ad, terraform.workspace)}"
}

// create a subnet with the requred CIDR, in the required availability domain and attech the SL and RT
resource "oci_core_subnet" "demo_sn" {
  compartment_id      = oci_identity_compartment.demo_compartment.id
  display_name        = "demo-${terraform.workspace}-sn${lookup(var.selected_ad, terraform.workspace)}"
  vcn_id              = oci_core_vcn.demo_vcn.id
  cidr_block          = "${lookup(var.vnc_cidr_range, terraform.workspace)}.${lookup(var.selected_ad, terraform.workspace)}.0/24"
  route_table_id      = oci_core_route_table.demo_rt.id
  security_list_ids   = ["${oci_core_security_list.demo_sl.id}"]
  availability_domain = data.oci_identity_availability_domain.demo_ad.name
}
