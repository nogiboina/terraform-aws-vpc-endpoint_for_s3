resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.Stream_VPC.id}"
  service_name = "com.amazonaws.us-east-1.s3"
  
}
# associate route table with VPC endpoint
resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
  route_table_id  = "${aws_route_table.Stream_VPC_route_table.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3.id}"
}