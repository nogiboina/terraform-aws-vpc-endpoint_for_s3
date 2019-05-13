resource "aws_instance" "public_instance" {
  ami  = "${lookup(var.amiForInstance, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.Stream_VPC_Subnet_Public.id}"
  vpc_security_group_ids = ["${aws_security_group.Stream_VPC_Security_Group_Public.id}"]
  tags = {
    Name = "public_instance"
  }
}

resource "aws_instance" "private_instance" {
  ami  = "${lookup(var.amiForInstance, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.Stream_VPC_Subnet_Private.id}"
  vpc_security_group_ids = ["${aws_security_group.Stream_VPC_Security_Group_Private.id}"]
  tags = {
    Name = "private_instance" 
  }
}
