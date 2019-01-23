variable "vpc_cidr_block" {
  default = "192.168.0.0/21"
}

variable "region" {
  default = "us-east-2"
}

variable "region-A" {
  default = "us-east-2b"
}

variable "region-B" {
  default = "us-east-2c"
}

variable "private_subnet_cidr_block" {
  default = "192.168.0.0/28"
}

variable "public_subnet_cidr_block" {
  default = "192.168.0.16/28"
}

variable "public_subnet_zone2_cidr_block" {
  default = "192.168.0.32/28"
}
