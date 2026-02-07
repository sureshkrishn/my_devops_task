variable "use1_region" {
  description = "AWS region for us-east-1 resources"
  type        = string
  default     = "us-east-1"
}

variable "use2_region" {
  description = "AWS region for us-east-2 resources"
  type        = string
  default     = "us-east-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "use1_key_name" {
  description = "EC2 key pair name for us-east-1"
  type        = string
}

variable "use2_key_name" {
  description = "EC2 key pair name for us-east-2"
  type        = string
}

variable "use1_sg_id" {
  description = "Security group ID for us-east-1"
  type        = string
}

variable "use2_sg_id" {
  description = "Security group ID for us-east-2"
  type        = string
}
