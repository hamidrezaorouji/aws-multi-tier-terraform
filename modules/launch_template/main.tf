resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096 
}

resource "aws_key_pair" "generated_key" {
  key_name   = "my_key"
  public_key = tls_private_key.ssh_key.public_key_openssh 
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh_key.private_key_pem
  filename        = "${path.module}/id_rsa"
  file_permission = "0600"
}

resource "aws_launch_template" "launchtemp" {
  name_prefix   = var.name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.generated_key.key_name

  vpc_security_group_ids = var.security_group_ids

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    hostname     = var.hostname
    project_name = var.project_name
  }))

  iam_instance_profile {
    name = var.instance_profile_name
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.name_prefix}-instance"
    }
  }
}
