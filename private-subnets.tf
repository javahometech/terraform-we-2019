# Private subnets
resource "aws_subnet" "private" {
  count      = "${length(local.az_names)}"
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, length(local.az_names) + count.index)}"

  tags = {
    Name = "PrivateSubnet-${count.index + 1}-${terraform.workspace}"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.my_vpc.id}"

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

  tags = {
    Name        = "JavaHomePrivateRT"
    Environment = "${terraform.workspace}"
  }
}

resource "aws_route_table_association" "pri_rt_association" {
  count          = "${length(local.az_names)}"
  subnet_id      = "${local.private_sub_ids[count.index]}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
