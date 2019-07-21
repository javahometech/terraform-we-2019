variable "vpc_cidr" {
  description = "Choose CIDR for VPC"
  type        = "string"
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "Choose region for your stack"
  type        = "string"
  default     = "ap-south-1"
}
variable "web_instance_count" {
  description = "Choose instance count"
  type        = "string"
  default     = "2"
}

variable "web_amis" {
  type = "map"
  default = {
    ap-south-1     = "ami-0d2692b6acea72ee6"
    ap-southeast-1 = "ami-01f7527546b557442"
  }
}

variable "vpc_tenancy" {
  description = "Choose tenancy for VPC"
  type        = "string"
  default     = "default"
}

variable "vpc_tags" {
  type        = "map"
  description = "Choos tags for VPC"
  default = {
    Name  = "main"
    Batch = "Weekends"
    Year  = "2019"
  }
}

variable "rds_pwd" {
  description = "Choose RDS password"
}

variable "elb_al_s3" {
  default = "javahome-we-accesslogs"
}
