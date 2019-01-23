variable "access_key" {}
variable "secret_key" {}
variable "public_key" {}


variable "region" {
  default = "us-east-2"
}

variable "key_name" {
  description = "aula key pair"
  default     = "aula_key"
}

variable "instance_type" {
  default = "t2.medium"
}