resource "aws_db_subnet_group" "rds" {
  name       = "rds_subnets"
  subnet_ids = "${local.private_sub_ids}"

  tags = {
    Name = "RDS Subnets"
  }
}

resource "aws_db_instance" "javahome" {
  identifier                = "javahome-${terraform.workspace}"
  vpc_security_group_ids    = ["${aws_security_group.rds.id}"]
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  name                      = "jvahomedb"
  username                  = "admin"
  password                  = "${var.rds_pwd}"
  parameter_group_name      = "default.mysql5.7"
  db_subnet_group_name      = "${aws_db_subnet_group.rds.id}"
  skip_final_snapshot       = false
  final_snapshot_identifier = "javahome-we-rds"
}

resource "aws_security_group" "rds" {
  name   = "rds_security-${terraform.workspace}"
  vpc_id = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
