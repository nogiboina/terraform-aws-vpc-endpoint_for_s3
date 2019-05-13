resource "aws_vpc" "Stream_VPC" {
  cidr_block           = "${var.vpcCIDRblock}"
  instance_tenancy     = "${var.instanceTenancy}" 
  enable_dns_support   = "${var.dnsSupport}" 
  enable_dns_hostnames = "${var.dnsHostNames}"
  tags {
      Name = "Stream VPC"
    }
} 

# create the Subnet
resource "aws_subnet" "Stream_VPC_Subnet_Public" {
  vpc_id                  = "${aws_vpc.Stream_VPC.id}"
  cidr_block              = "${var.subnetCIDRblock}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
  tags = {
     Name = "Stream VPC Public Subnet"
    }
} 

resource "aws_subnet" "Stream_VPC_Subnet_Private" {
  vpc_id                  = "${aws_vpc.Stream_VPC.id}"
  cidr_block              = "${var.subnetCIDRblock1}"
  map_public_ip_on_launch = "${var.mapPublicIP}" 
  availability_zone       = "${var.availabilityZone}"
  map_public_ip_on_launch =  "false"
  tags = {
     Name = "Stream VPC Private Subnet"
    }
} 

# Create the Security Group
resource "aws_security_group" "Stream_VPC_Security_Group_Private" {
  vpc_id       = "${aws_vpc.Stream_VPC.id}"
  name         = "Stream VPC Security Group Private"
  description  = "Stream VPC Security Group Private"
ingress {
    security_groups = ["${aws_security_group.Stream_VPC_Security_Group_Public.id}"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]  
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
          Name = "Stream VPC Security Group Private"
    }
} 

resource "aws_security_group" "Stream_VPC_Security_Group_Public" {
  vpc_id       = "${aws_vpc.Stream_VPC.id}"
  name         = "Stream VPC Security Group Public"
  description  = "Stream VPC Security Group Public"
  ingress {
    cidr_blocks = ["${var.ingressCIDRblockPub}"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  egress {
    cidr_blocks = ["${var.ingressCIDRblockPub}"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
          Name = "Stream VPC Security Group Public"
    }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "Stream_VPC_GW" {
  vpc_id = "${aws_vpc.Stream_VPC.id}"
tags {
        Name = "Stream VPC Internet Gateway"
    }
} 

# Create the Route Table
resource "aws_route_table" "Stream_VPC_route_table" {
    vpc_id = "${aws_vpc.Stream_VPC.id}"
tags {
        Name = "Stream VPC Route Table"
    }
} 

# Create the Internet Access
resource "aws_route" "Stream_VPC_internet_access" {
  route_table_id        = "${aws_route_table.Stream_VPC_route_table.id}"
  destination_cidr_block = "${var.destinationCIDRblock}"
  gateway_id             = "${aws_internet_gateway.Stream_VPC_GW.id}"
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "Stream_VPC_association" {
    subnet_id      = "${aws_subnet.Stream_VPC_Subnet_Public.id}"
    route_table_id = "${aws_route_table.Stream_VPC_route_table.id}"
} # end resource

#create S3 bucket
resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket_name}"
  acl    = "private"
  tags = {
    Name        = "Stream bucket"
    Environment = "VPC_EndPoint_Testing"
  }
}