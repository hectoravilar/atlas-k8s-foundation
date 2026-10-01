# Creates the Public Route Table. 
# Subnets associated with this table will have direct access to the Internet.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.vpc_name}-public-rt"
    Environment = var.environment
    Terraform   = "true"
  }
}

# Creates the Private Route Table. 
# Subnets associated with this table are completely isolated from inbound Internet traffic.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.vpc_name}-private-rt"
    Environment = var.environment
    Terraform   = "true"
  }
}

# Injects a default route (0.0.0.0/0) into the Public Route Table.
# All outbound traffic is routed through the Internet Gateway (IGW).
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Injects a default route (0.0.0.0/0) into the Private Route Table.
# All outbound traffic (e.g., pulling Docker images or OS updates) is routed 
# securely through the NAT Gateway, masking the instances' private IPs.
resource "aws_route" "private_internet_access" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}



# Dynamically associates all generated Public Subnets to the Public Route Table.
# We use length(aws_subnet.public) to ensure strict parity with created resources.
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Dynamically associates all generated Private Subnets to the Private Route Table.
# EKS worker nodes will reside in these subnets.
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
