data "aws_ami" "web" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

resource "aws_instance" "web" {
  count = "${var.web_instance_count}"
  # ami           = "${data.aws_ami.web.id}"
  ami                    = "${var.web_amis[var.region]}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  user_data              = "${file("scripts/apache.sh")}"
  subnet_id              = "${local.pub_sub_ids[count.index]}"
  tags = {
    Name        = "WebApp-${count.index + 1}"
    Environment = "${terraform.workspace}"
  }
}
