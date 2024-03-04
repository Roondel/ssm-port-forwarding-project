resource "aws_vpc" "bastion_project_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "bastion_project_vpc"
  }
}
resource "aws_subnet" "bastion_project_subnet_1" {
  vpc_id            = aws_vpc.bastion_project_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "ec2 subnet for bastion"
  }
}
resource "aws_route_table" "internal" {
  vpc_id = aws_vpc.bastion_project_vpc.id
  route {
    cidr_block = "10.0.0.0/16"
    gateway_id = "local"
  }

}
resource "aws_route_table_association" "internal" {
  subnet_id      = aws_subnet.bastion_project_subnet_1.id
  route_table_id = aws_route_table.internal.id
}
