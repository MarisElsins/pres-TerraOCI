resource "oci_identity_compartment" "demo_compartment" {
  name           = "${terraform.workspace}-compartment"
  description    = "${terraform.workspace}-compartment"
  compartment_id = var.OCITerra_compartment_ocid
  enable_delete  = true
}
