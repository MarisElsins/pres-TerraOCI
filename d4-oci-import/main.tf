// OCITerra-Manual
variable adb_compartment {}

// Resources https://www.terraform.io/docs/providers/oci/index.html
// https://www.terraform.io/docs/providers/oci/r/database_autonomous_database.html

resource "oci_database_autonomous_database" "test_autonomous_database" {
  /*
    // Required
    admin_password = "Welcome123%%%"
    compartment_id = var.adb_compartment
    cpu_core_count = "1"
    data_storage_size_in_tbs = "1"
    db_name = "DevClub"

    // Optional
    is_free_tier = true
  */
}
