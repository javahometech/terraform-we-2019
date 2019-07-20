#!/bin/bash

yum install httpd -y
systemctl enable httpd
systemctl start httpd
echo "<h1>This app is on AWS!!!</h1>" > /var/www/html/index.html
