resource "aws_instance" "github-ec2" {
  ami           = "ami-00381a880aa48c6c6"
  instance_type = "t3.xlarge"
  key_name      = "tagal-key"
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.github-sg.id]
  user_data = file("script.sh")
  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "EC2-SHGitHub-tagal"
  }
}

resource "aws_security_group" "github-sg" {
  name        = "tagal-SHGitHub-security-group"
  description = "Security group for SHGitHub service"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
