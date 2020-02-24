resource "oci_core_instance" "demo_instance" {
  availability_domain = data.oci_identity_availability_domain.demo_ad.name
  compartment_id      = oci_identity_compartment.demo_compartment.id
  display_name        = "demo-${terraform.workspace}-instance"
  shape               = lookup(var.instance_shape, terraform.workspace, "VM.Standard2.1")
  create_vnic_details {
    subnet_id        = oci_core_subnet.demo_sn.id
    assign_public_ip = "true"
  }
  source_details {
    source_type             = "image"
    source_id               = lookup(var.available_images,lookup(var.selected_image, terraform.workspace))
    boot_volume_size_in_gbs = "50"
  }
  preserve_boot_volume = false
  metadata = {
    ssh_authorized_keys = var.ssh_authorized_key
    user_data           = base64encode(file("./userdata/${terraform.workspace}-bootstrap"))
  }
}
