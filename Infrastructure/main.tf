resource "aws_instance" "private_server" {

  instance_type = "t2.micro"
  ami           = data.aws_ami.server_ami.id
  subnet_id     = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "Private"
  }

}



resource "aws_instance" "public_server" {

  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  user_data              = file("userdata.tpl")
  key_name               = aws_key_pair.main_key.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  subnet_id              = aws_subnet.public.id

  tags = {
    Name = "Public"
  }


}



resource "aws_key_pair" "main_key" {
  key_name   = "devops-project1"
  public_key = file("~/.ssh/devops-project1.pub")

}