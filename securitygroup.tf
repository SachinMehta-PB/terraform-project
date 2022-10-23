resource "aws_security_group" "terraform-bean-elb-sg" {
  name = "terraform-bean-elb-sg"
  description = "Security Group for bean elb"
  vpc_id = "module.vpc.vpc_id" # It will check from module->vpc->vpcid
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "terraform-bastion-sg" {
  name = "terraform-bastion-sg"
  description = "Security group for  bastionisioner ec2 instance"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = [var.MYIP]
  }
}

resource "aws_security_group" "terraform-prod-sg" {
  name = "terraform-prod-sg"
  description = "Security group for beanstalk instances"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    security_groups = [aws_security_group.terraform-bastion-sg.id]
  }
}

resource "aws_security_group" "terraform-backend-sg" {
  name = "terraform-backend-sg"
  description = "Security group for RDS, Active MQ, and Elastic cache"
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    security_groups = [aws_security_group.terraform-prod-sg.id]
  }
}

resource "aws_security_group_rule" "sec_group_allow_itself" {
  from_port         = 0
  protocol          = "tcp"
  to_port           = 65535
  type              = "ingress"
  security_group_id = aws_security_group.terraform-backend-sg.id
  source_security_group_id = aws_security_group.terraform-backend-sg.id
}
