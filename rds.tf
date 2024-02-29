resource  "aws_security_group" "rds_sg"{
    name = "rds-sg"
    vpc_id = aws_vpc.bastion_project_vpc.id
    
}
resource "aws_security_group_rule" "rds_ingress_5432"{
    type = "ingress"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    source_security_group_id = aws_security_group.bastion_sg.id
    security_group_id = aws_security_group.rds_sg.id
}

# Create the RDS PostgreSQL database instance
resource "aws_db_instance" "rds_instance" {
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "11"
  instance_class         = "db.t3.micro" 
  username               = "user"
  password               = "password" 
  db_subnet_group_name   = aws_db_subnet_group.rds-subnet-group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  identifier = "postgresql"
}
# Create the database subnet group, associated with the created subnet
resource "aws_db_subnet_group" "rds-subnet-group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.db_subnet_1.id,aws_subnet.db_subnet_2.id]
}
# Create a subnet for the RDS subnet group
resource "aws_subnet" "db_subnet_1" {
  vpc_id     = aws_vpc.bastion_project_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a" 
}
# Create a subnet for the RDS subnet group
resource "aws_subnet" "db_subnet_2" {
  vpc_id     = aws_vpc.bastion_project_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b" 
}
