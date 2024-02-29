resource  "aws_security_group" "vpce_sg"{
    name = "vpc-endpoints-sg"
    vpc_id = aws_vpc.bastion_project_vpc.id
}
resource "aws_security_group_rule" "vpce_sg_rule_ingress"{
    type = "ingress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
    security_group_id = aws_security_group.vpce_sg.id
}
resource "aws_security_group_rule" "vpce_sg_rule_egress"{
    type = "egress"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    source_security_group_id = aws_security_group.bastion_sg.id
    security_group_id = aws_security_group.vpce_sg.id
}

resource "aws_vpc_endpoint" "rds_endpoint"{
    vpc_id = aws_vpc.bastion_project_vpc.id
    vpc_endpoint_type = "Interface"
    service_name = "com.amazonaws.${var.region}.rds"
    security_group_ids = [aws_security_group.vpce_sg.id]
    subnet_ids = [aws_subnet.bastion_project_subnet_1.id]

}
resource "aws_vpc_endpoint" "ssm_endpoint"{
    vpc_id = aws_vpc.bastion_project_vpc.id
    vpc_endpoint_type = "Interface"
    service_name = "com.amazonaws.${var.region}.ssm"
    security_group_ids = [aws_security_group.vpce_sg.id]
    subnet_ids = [aws_subnet.db_subnet_1.id,aws_subnet.db_subnet_2.id]

}
resource "aws_vpc_endpoint" "ssm_messages_endpoint"{
    vpc_id = aws_vpc.bastion_project_vpc.id
    vpc_endpoint_type = "Interface"
    service_name = "com.amazonaws.${var.region}.ssmmessages"
    security_group_ids = [aws_security_group.vpce_sg.id]
    subnet_ids = [aws_subnet.db_subnet_1.id,aws_subnet.db_subnet_2.id]

}
resource "aws_vpc_endpoint" "ec2_messages_endpoint"{
    vpc_id = aws_vpc.bastion_project_vpc.id
    vpc_endpoint_type = "Interface"
    service_name = "com.amazonaws.${var.region}.ec2messages"
    security_group_ids = [aws_security_group.vpce_sg.id]
    subnet_ids = [aws_subnet.db_subnet_1.id,aws_subnet.db_subnet_2.id]

}
   