output "launch_template_id" {
  value = aws_launch_template.launchtemp.id
}

output "private_key_path" {
  value = local_file.private_key.filename
}
