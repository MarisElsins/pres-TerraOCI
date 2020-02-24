output "fileset1_file_names" {
  value = [module.fileset1.file_name, module.fileset1-dr.file_name]
}

output "fileset1_file_content" {
  value = [module.fileset1.file_content, module.fileset1-dr.file_content]
}
