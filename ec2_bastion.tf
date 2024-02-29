resource "aws_instance" "bastion_host_rds" {
    subnet_id = aws_subnet.bastion_project_subnet_1.id
    instance_type = "t3.micro"
    ami = data.aws_ami.amazon_linux.id
    associate_public_ip_address = false
    iam_instance_profile = aws_iam_instance_profile.bastion_iam_profile.name  

    tags = {
      Name = "bastion_host_rds"
    }
}
data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource  "aws_security_group" "bastion_sg"{
    name = "ec2-bastion-sg"
    vpc_id = aws_vpc.bastion_project_vpc.id
}
resource "aws_security_group_rule" "bastion_sg_rule_443"{
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = aws_security_group.vpce_sg.id
    security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "bastion_sg_rule_5432"{
    type = "ingress"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    source_security_group_id = aws_security_group.vpce_sg.id
    security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "bastion_sg_rule_egress_5432"{
    type = "egress"
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    source_security_group_id = aws_security_group.rds_sg.id
    security_group_id = aws_security_group.bastion_sg.id
}
resource "aws_security_group_rule" "bastion_sg_rule_egress_443"{
    type = "egress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = aws_security_group.vpce_sg.id
    security_group_id = aws_security_group.bastion_sg.id
}