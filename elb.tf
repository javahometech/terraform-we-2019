# Create a new load balancer
resource "aws_elb" "javahome_elb" {
  name            = "javahome-elb"
  subnets         = "${local.pub_sub_ids}"
  security_groups = ["${aws_security_group.elb.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  access_logs {
    bucket = "${aws_s3_bucket.accesslogs.id}"
    # bucket_prefix = "javahome-elb"
    interval = 60
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = "${aws_instance.web.*.id}"
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 30

}


resource "aws_security_group" "elb" {
  name   = "elb_security"
  vpc_id = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
