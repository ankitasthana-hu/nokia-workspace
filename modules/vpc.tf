provider "aws" {
  access_key = "AKIA5FZGOBW3S7GYUXID"
  secret_key = "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"
  region     = "us-east-1"
  version = "v2.70.0"
}
   
# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "131.228.2.0/27"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "main"
  }
}

# Subnets
resource "aws_subnet" "main-public-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "131.228.3.0/28"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-public-1"
  }
}

resource "aws_subnet" "main-public-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "131.228.4.0/28"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-public-2"
  }
}

resource "aws_subnet" "main-public-3" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "131.228.5.0/28"
  map_public_ip_on_launch = "true"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "main-public-3"
  }
}

resource "aws_subnet" "main-private-1" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "131.228.6.0/28"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "main-private-1"
  }
}

resource "aws_subnet" "main-private-2" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "131.228.7.0/28"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1b"

  tags = {
    Name = "main-private-2"
  }
}

resource "aws_subnet" "main-private-3" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "131.228.8.0/28"
  map_public_ip_on_launch = "false"
  availability_zone       = "us-east-1c"

  tags = {
    Name = "main-private-3"
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main-gw.id}"
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public-1-a" {
  subnet_id      = "${aws_subnet.main-public-1.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-2-a" {
  subnet_id      = "${aws_subnet.main-public-2.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}

resource "aws_route_table_association" "main-public-3-a" {
  subnet_id      = "${aws_subnet.main-public-3.id}"
  route_table_id = "${aws_route_table.main-public.id}"
}
