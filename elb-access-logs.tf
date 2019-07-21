
locals {
  bucket_name = "${var.elb_al_s3}-${terraform.workspace}"
}
resource "aws_s3_bucket" "accesslogs" {
  bucket = "${local.bucket_name}"
  acl    = "private"
  region = "${var.region}"
  policy = "${data.template_file.accesslogs.rendered}"
  tags = {
    Name        = "JavaHome"
    Environment = "${terraform.workspace}"
  }
}

data "template_file" "accesslogs" {
  template = "${file("iam/elb-s3-access-logs-policy.json")}"
  vars = {
    elb_s3_bucket_name = "${local.bucket_name}"
  }
}
