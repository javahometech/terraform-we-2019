provider "aws" {
  region = "${var.region}"
}
terraform {
  backend "s3" {
    bucket         = "javahome-we-789"
    key            = "javahome-app/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"

  tags = "${var.vpc_tags}"
}


resource "aws_subnet" "public" {

  count                   = "${length(local.az_names)}"
  vpc_id                  = "${aws_vpc.my_vpc.id}"
  cidr_block              = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  map_public_ip_on_launch = true
  availability_zone       = "${local.az_names[count.index]}"
  tags = {
    Name = "Subnet-${count.index + 1}-${terraform.workspace}"
  }
}


# Create Internet Gatewway for Public subnets

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  tags = {
    Name        = "JavaHomeIGW"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table" "pub_rt" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags = {
    Name        = "JavaHomePubRT"
    Environment = "${terraform.workspace}"
  }
}


# Public subnet and route table association

resource "aws_route_table_association" "pub_rt_association" {
  count          = "${length(local.az_names)}"
  subnet_id      = "${local.pub_sub_ids[count.index]}"
  route_table_id = "${aws_route_table.pub_rt.id}"
}
output "az_names" {
  value = "${local.az_names}"
}
