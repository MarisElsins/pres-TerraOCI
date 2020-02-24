resource "random_string" "rstring" {
  length  = 16
  special = true
}
resource "local_file" "file" {
  content  = "This is the random string: ${random_string.rstring.result}"
  filename = "../temp/demo-1-${var.file_prefix}.txt"
}
