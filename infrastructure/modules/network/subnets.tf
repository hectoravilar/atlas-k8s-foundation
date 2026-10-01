# Create Public Subnets dynamically across multiple AZs
resource "aws_subnet" "public" {
  count  = length(var.azs)
  vpc_id = aws_vpc.main.id


  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true # Essential for ALB Ingress controllers

  tags = {
    Name                     = "${var.vpc_name}-public-${var.azs[count.index]}"
    Environment              = var.environment
    Terraform                = "true"
    "kubernetes.io/role/elb" = "1"
  }
}

# Create Private Subnets dynamically across multiple AZs
resource "aws_subnet" "private" {
  count  = length(var.azs)
  vpc_id = aws_vpc.main.id


  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 10)

  availability_zone = var.azs[count.index]

  tags = {
    Name                              = "${var.vpc_name}-private-${var.azs[count.index]}"
    Environment                       = var.environment
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "karpenter.sh/discovery"          = "atlas-k8s-foundation"
  }
}
