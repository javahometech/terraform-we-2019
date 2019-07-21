data "aws_ami" "nat" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "nat" {
  ami               = "${data.aws_ami.nat.id}"
  instance_type     = "t2.micro"
  source_dest_check = false
  subnet_id         = "${local.pub_sub_ids[1]}"
  tags = {
    Name        = "JavaHomeNat"
    Environment = "${terraform.workspace}"
  }
}
