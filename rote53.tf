data "aws_route53_zone" "javahome" {
  name         = "javahome123.tk."
  private_zone = false
}

resource "aws_route53_record" "javahome" {
  zone_id = "${data.aws_route53_zone.javahome.zone_id}"
  name    = "javahome123.tk."
  type    = "A"
  alias {
    name                   = "${aws_elb.javahome_elb.dns_name}"
    zone_id                = "${aws_elb.javahome_elb.zone_id}"
    evaluate_target_health = false
  }
}
