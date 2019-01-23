# ---------------------------------------------------------------------------------------------------------------------
# SPECIFY THE CLOUD-PROVIDER TO USE
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

# ---------------------------------------------------------------------------------------------------------------------
# USE THE VPC MODULE TO CREATE THE CUSTOM VIRTUAL PRIVATE CLOUD
# ---------------------------------------------------------------------------------------------------------------------

module "vpc" {
  source = "./modules/vpc"
}

# ---------------------------------------------------------------------------------------------------------------------
# GET THE ELASTIC CLUSTER IMAGE
# ---------------------------------------------------------------------------------------------------------------------

data "aws_ami" "elastic_cluster_ami" {
  most_recent = true

  filter {
    name = "name"
    values = ["ElasticSearch-setup*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SSH KEY TO LOGIN INTO THE ELASTICSEARCH CLUSTER SERVER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_key_pair" "aula_ssh_key" {
  key_name   = "${var.key_name}"
  public_key = "${var.public_key}"
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE ELASTICSEARCH CLUSTER SERVER
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "web_instance" {
  ami   = "${data.aws_ami.elastic_cluster_ami.id}"
  user_data     = "${file("userdata")}"
  instance_type = "${var.instance_type}"
  subnet_id = "${module.vpc.public_subnet}"
  associate_public_ip_address = true
  private_ip  = "192.168.0.24"
  security_groups = ["${module.vpc.security_groups}"]
  key_name  = "${var.key_name}"

  tags {
    Name  = "elastic-search-cluster"
  }
}