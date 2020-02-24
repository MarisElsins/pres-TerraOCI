module "fileset1" {
  source      = "../d1-basic"
  file_prefix = var.f1
}

module "fileset1-dr" {
  source      = "../d1-basic"
  file_prefix = "${var.f1}-dr"
}
