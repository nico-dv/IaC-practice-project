resource "aws_instance" "server" {

  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  subnet_id              = aws_subnet.private.id


  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "Server"
  }

}



resource "aws_instance" "client" {
  
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  subnet_id              = aws_subnet.public.id


  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "Client"
  }

}