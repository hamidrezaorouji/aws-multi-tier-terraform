output "lauch_template_id" {
  value = aws_lauch_template.launchtemp.id
}

output "private_key_path" {
  value = local_file.private_key.filename
}
