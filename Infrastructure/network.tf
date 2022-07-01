


resource "aws_vpc" "project1-vpc" {
  cidr_block = "192.168.0.0/16"
  
  tags = {
    Name = "Project-1-VPC"
  }

}