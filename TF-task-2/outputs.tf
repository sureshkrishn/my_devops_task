output "us_east_1_instance_details" {
  description = "Instance details for us-east-1"
  value = {
    instance_id = aws_instance.ubuntu_use1.id
    public_ip   = aws_instance.ubuntu_use1.public_ip
    url         = "http://${aws_instance.ubuntu_use1.public_ip}"
  }
}

output "us_east_2_instance_details" {
  description = "Instance details for us-east-2"
  value = {
    instance_id = aws_instance.ubuntu_use2.id
    public_ip   = aws_instance.ubuntu_use2.public_ip
    url         = "http://${aws_instance.ubuntu_use2.public_ip}"
  }
}
