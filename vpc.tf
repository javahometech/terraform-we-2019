provider "aws" {
  region = "ap-south-1"
}
terraform {
  backend "s3" {
    bucket         = "javahome-tf-789"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
  }
}
resource "aws_vpc" "my_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "${var.vpc_tenancy}"

  tags = "${var.vpc_tags}"
}


resource "aws_subnet" "main" {
  count      = 2
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "${var.subnet_cidrs[count.index]}"

  tags = {
    Name = "Subnet-${count.index + 1}-${terraform.workspace}"
  }
}
