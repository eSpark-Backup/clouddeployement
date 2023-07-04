terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}
# Create VPC 
resource "aws_vpc" "tf_vpc1" {
  cidr_block           = "192.168.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "tf_vpc1"
  }
}
# Create SGs
resource "aws_security_group" "tf_sg1" {
  name        = "tf_sg1"
  description = "This firewall allows SSH, HTTP and MYSQL"
  vpc_id      = aws_vpc.tf_vpc1.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "TCP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf_sg1"
  }
}

# Create Subnet
resource "aws_subnet" "tf_public" {
  vpc_id                  = aws_vpc.tf_vpc1.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "tf_public_subnet"
  }
}
resource "aws_subnet" "tf_private" {
  vpc_id            = aws_vpc.tf_vpc1.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "eu-north-1b"

  tags = {
    Name = "tf_private_subnet"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "tf_internet_gateway" {
  vpc_id = aws_vpc.tf_vpc1.id

  tags = {
    Name = "tf_internet_gateway"
  }
}

# Create Route Table
resource "aws_route_table" "tf_rt1" {
  vpc_id = aws_vpc.tf_vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_internet_gateway.id
  }

  tags = {
    Name = "tf_rt1"
  }
}

# Assosiate route table to subnets
resource "aws_route_table_association" "tf_a" {
  subnet_id      = aws_subnet.tf_public.id
  route_table_id = aws_route_table.tf_rt1.id
}
resource "aws_route_table_association" "tf_b" {
  subnet_id      = aws_subnet.tf_private.id
  route_table_id = aws_route_table.tf_rt1.id
}

# Create ec2 instance for wordpress
resource "aws_instance" "tf_wordpress" {
 ami = "ami-0c858d4d1feca5370"
 instance_type = "t3.micro"
#  key_name = "${aws_key_pair.generated_key.key_name}"
 vpc_security_group_ids = [ "${aws_security_group.tf_sg1.id}" ]
 subnet_id = "${aws_subnet.tf_public.id}"
 
 tags = {
  Name = "tf_wordpress"
 }
}

# Add ec2 instance for mysql
resource "aws_instance" "tf_mysql" {
 ami = "ami-0c858d4d1feca5370"
 instance_type = "t3.micro"
#  key_name = "${aws_key_pair.generated_key.key_name}"
 vpc_security_group_ids = [ "${aws_security_group.tf_sg1.id}" ]
 subnet_id = "${aws_subnet.tf_private.id}"
  
 tags = {
  Name = "tf_mysql"
 }
}