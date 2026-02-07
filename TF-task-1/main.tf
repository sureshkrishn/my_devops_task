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
  region = "us-east-1"
  alias  = "use1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "use2"
}

########################################
# Ubuntu 24.04 AMI lookup
########################################

data "aws_ami" "ubuntu_use1" {
  provider    = aws.use1
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*noble*amd64*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu_use2" {
  provider    = aws.use2
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/*noble*amd64*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

########################################
# EC2 – us-east-1
########################################

resource "aws_instance" "ubuntu_use1" {
  provider      = aws.use1
  ami           = data.aws_ami.ubuntu_use1.id
  instance_type = "t3.micro"

  key_name               = "aws-n.virginia-kp1"
  vpc_security_group_ids = ["sg-00a2f31d53b5d29fe"]

  tags = {
    Name   = "ubuntu-24.04-useast1"
    Region = "us-east-1"
  }
}

########################################
# EC2 – us-east-2
########################################

resource "aws_instance" "ubuntu_use2" {
  provider      = aws.use2
  ami           = data.aws_ami.ubuntu_use2.id
  instance_type = "t3.micro"

  key_name               = "aws-ohio-kp1"
  vpc_security_group_ids = ["sg-0bd630e10237f41a9"]

  tags = {
    Name   = "ubuntu-24.04-useast2"
    Region = "us-east-2"
  }
}

########################################
# Outputs
########################################

output "us_east_1_instance_details" {
  description = "EC2 instance ID and public IP in us-east-1"
  value = {
    instance_id = aws_instance.ubuntu_use1.id
    public_ip   = aws_instance.ubuntu_use1.public_ip
  }
}

output "us_east_2_instance_details" {
  description = "EC2 instance ID and public IP in us-east-2"
  value = {
    instance_id = aws_instance.ubuntu_use2.id
    public_ip   = aws_instance.ubuntu_use2.public_ip
  }
}
