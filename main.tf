provider "aws" {
  region = var.region

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

resource "aws_instance" "devops_server" {

  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  user_data = file("user-data.sh")

  tags = {
    Name = "DevOpsTerraformServer"
  }
}
