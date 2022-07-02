

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "Project1_VPC"
  }

}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project1_PRIVATE"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project1_PUBLIC"
  }
}

resource "aws_internet_gateway" "main_ig" {
  vpc_id = aws_vpc.main.id

  depends_on = [aws_internet_gateway.main_ig]

  tags = {
    Name = "Project1_IG"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "project1-RT"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_ig.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}


