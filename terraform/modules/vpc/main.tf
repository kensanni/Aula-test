# ---------------------------------------------------------------------------------------------------------------------
# LAUNCH A CUSTOM VIRTUAL PRIVATE CLOUD
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_vpc" "aula_vpc" {
  cidr_block        = "${var.vpc_cidr_block}"
  instance_tenancy  = "default"
  enable_dns_hostnames = true

  tags {
    Name = "aula_vpc"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A PRIVATE SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "private_subnet" {
  vpc_id              = "${aws_vpc.aula_vpc.id}"
  cidr_block          = "${var.private_subnet_cidr_block}"
  availability_zone   = "${var.region-A}"

  tags  {
    Name = "aula-private-subnet"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A PUBLIC SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "public_subnet" {
  vpc_id              = "${aws_vpc.aula_vpc.id}"
  cidr_block          = "${var.public_subnet_cidr_block}"
  availability_zone   = "${var.region-A}"

  tags  {
    Name = "aula-public-subnet"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A PUBLIC SUBNET IN A DIFFERENT ZONE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_subnet" "public_subnet_zone2" {
  vpc_id              = "${aws_vpc.aula_vpc.id}"
  cidr_block          = "${var.public_subnet_zone2_cidr_block}"
  availability_zone   = "${var.region-B}"

  tags  {
    Name = "aula-public-subnet-zone2"
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# CREATE A ROUTE TABLE FOR THE PUBLIC SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "aula_route_table" {
  vpc_id  = "${aws_vpc.aula_vpc.id}"

  tags {
    Name  = "aula_route_table_pub"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE A ROUTE TABLE FOR THE PRIVATE SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table" "aula_priv_route_table" {
  vpc_id  = "${aws_vpc.aula_vpc.id}"

  tags {
    Name  = "aula_route_table_priv"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE AN INTERNET GATEWAY FOR VPC TO SEND TRAFFIC OUT
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_internet_gateway" "aula_route_table" {
  vpc_id  = "${aws_vpc.aula_vpc.id}"

  tags {
    Name = "aula_internet_gateway"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# EDIT THE ROUTE TABLE TO INCLUDE THE INTERNET GATEWAY 
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route" "aula_route_table" {
  gateway_id              = "${aws_internet_gateway.aula_route_table.id}"
  route_table_id          = "${aws_route_table.aula_route_table.id}"
  destination_cidr_block  = "0.0.0.0/0"
}

# ---------------------------------------------------------------------------------------------------------------------
# ASSOCIATE THE ROUTE TABLE WITH THE PUBLIC SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table_association" "aula_public" {
  subnet_id       = "${aws_subnet.public_subnet.id}"
  route_table_id  = "${aws_route_table.aula_route_table.id}"
}

# ---------------------------------------------------------------------------------------------------------------------
# ASSOCIATE THE ROUTE TABLE WITH THE PRIVATE SUBNET
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_route_table_association" "aula_private" {
  subnet_id       = "${aws_subnet.private_subnet.id}"
  route_table_id  = "${aws_route_table.aula_priv_route_table.id}"
}