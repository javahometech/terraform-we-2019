variable "vpc_cidr" {
  description = "Choose CIDR for VPC"
  type        = "string"
  default     = "10.0.0.0/16"
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

variable "subnet_cidrs" {
  description = "Choose CIDR for subnet"
  type        = "list"
  default     = ["10.20.1.0/24", "10.20.2.0/24"]
}
