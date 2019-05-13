variable "region" {
	default = "us-east-1"
}
variable "amiForInstance" {
type = "map"
default = {
  us-east-1 = "ami-0de53d8956e8dcf80"
  us-east-2 = "ami-0080e4c5bc078760e"
  us-west-1 = "ami-011b3ccf1bd6db744"
  }
}
variable "profile" {
  default = "default"
}
variable "availabilityZone" {
  default = "us-east-1a"
}
variable "instanceTenancy" {
  default = "default"
}
variable "dnsSupport" {
  default = true
}
variable "dnsHostNames" {
  default = true
}
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}
variable "subnetCIDRblock" {         
  default = "10.0.0.0/24"
}
variable "subnetCIDRblock1" {         
  default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {  
  default = "0.0.0.0/0"
}
variable "ingressCIDRblockPriv" {
  type = "string"
  default = "10.0.1.0/24"
}
variable "ingressCIDRblockPub" {
  type = "string"
  default = "0.0.0.0/0" 
}
variable "mapPublicIP" {
  default = true
}
variable "bucket_name" {
  type = "string"
  default = "serviceappsbucket"
}
