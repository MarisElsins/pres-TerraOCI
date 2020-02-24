variable "file_prefix" {
  default = "default"
}

// default value
// interactive input
// terraform.tfvars
// terraform apply -var 'file_prefix=nondefault'
// export TF_VAR_file_prefix=nondefault
