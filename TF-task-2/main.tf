terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

########################################
# Providers
########################################

provider "aws" {
  alias  = "use1"
  region = var.use1_region
}

provider "aws" {
  alias  = "use2"
  region = var.use2_region
}

########################################
# Ubuntu 24.04 AMI lookup (FIXED)
########################################

data "aws_ami" "ubuntu_use1" {
  provider    = aws.use1
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ami" "ubuntu_use2" {
  provider    = aws.use2
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

########################################
# EC2 – us-east-1
########################################

resource "aws_instance" "ubuntu_use1" {
  provider      = aws.use1
  ami           = data.aws_ami.ubuntu_use1.id
  instance_type = var.instance_type

  key_name               = var.use1_key_name
  vpc_security_group_ids = [var.use1_sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Nginx running in us-east-1</h1>" > /var/www/html/index.html
              EOF

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name   = "ubuntu-24.04-useast1"
    Region = var.use1_region
  }
}

########################################
# EC2 – us-east-2
########################################

resource "aws_instance" "ubuntu_use2" {
  provider      = aws.use2
  ami           = data.aws_ami.ubuntu_use2.id
  instance_type = var.instance_type

  key_name               = var.use2_key_name
  vpc_security_group_ids = [var.use2_sg_id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Nginx running in us-east-2</h1>" > /var/www/html/index.html
              EOF

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name   = "ubuntu-24.04-useast2"
    Region = var.use2_region
  }
}
