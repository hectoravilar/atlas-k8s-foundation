
# 1. Internet Gateway (Allows public subnets to reach the internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id # This now correctly references the VPC created in vpc.tf

  tags = {
    Name        = "${var.vpc_name}-igw"
    Environment = var.environment
    Terraform   = "true"
  }
}

# 2. Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name        = "${var.vpc_name}-nat-eip"
    Environment = var.environment
    Terraform   = "true"
  }
}

# 3. NAT Gateway (Allows private subnets to reach the internet, e.g., to pull Docker images)
# For a Dev environment, a Single NAT Gateway is highly recommended to save costs.
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id

  # We will reference the first public subnet here once you create subnets.tf
  # subnet_id = aws_subnet.public[0].id 
  subnet_id = aws_subnet.public[0].id # This references the first public subnet created in subnets.tf
  tags = {
    Name        = "${var.vpc_name}-nat"
    Environment = var.environment
    Terraform   = "true"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}
