locals {
  az_names        = "${data.aws_availability_zones.azs.names}"
  pub_sub_ids     = "${aws_subnet.public.*.id}"
  private_sub_ids = "${aws_subnet.private.*.id}"
}
