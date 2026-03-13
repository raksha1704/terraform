provider "aws" {
  region = var.region

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

# Security Group
resource "aws_security_group" "app_sg" {
  name = "terraform-app-sg"

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Flask EC2 Instance
resource "aws_instance" "flask_server" {

  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.app_sg.name]

  user_data = file("flask-userdata.sh")

  tags = {
    Name = "FlaskServer"
  }
}

# Express EC2 Instance
resource "aws_instance" "express_server" {

  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.app_sg.name]

  user_data = file("express-userdata.sh")

  tags = {
    Name = "ExpressServer"
  }
}
