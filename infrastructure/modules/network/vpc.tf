# We use the raw aws_vpc resource to build our foundation from scratch.
# Hardcoded values (like CIDR) should be moved to variables so this module is reusable.

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true # Required for EKS nodes to register properly
  enable_dns_support   = true # Required for EKS cluster internal DNS

  tags = {
    Name        = var.vpc_name
    Environment = var.environment
    Terraform   = "true"
  }
}
