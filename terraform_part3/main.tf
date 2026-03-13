provider "aws" {
  region = var.region

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
}

# VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.1.0/24"
}

# Security Group
resource "aws_security_group" "ecs_sg" {

  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

# ECR repositories
resource "aws_ecr_repository" "flask_repo" {
  name = "flask-backend"
}

resource "aws_ecr_repository" "express_repo" {
  name = "express-frontend"
}

# ECS cluster
resource "aws_ecs_cluster" "main_cluster" {
  name = "devops-cluster"
}

