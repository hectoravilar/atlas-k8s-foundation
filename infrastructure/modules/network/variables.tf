variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "atlas-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "The environment"
  type        = string
  default     = "dev"
}

variable "public_subnet_id_for_nat" {
  description = "The ID of the public subnet to place the NAT Gateway in"
  type        = string
  default     = ""
}

variable "azs" {
  description = "List of Availability Zones in the region"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}





