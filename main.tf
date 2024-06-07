#Set terraform providers
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

#Add security group to allow port 22 and 80 traffic
resource "aws_security_group" "TF_SG" {
  name        = var.sg_name
  description = var.sg_name
  vpc_id      = var.vpc_id

  ingress {
    description = var.http_desc
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.protocol_tcp
    cidr_blocks = var.cidr_block
  }

  ingress {
    description = var.ssh_desc
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.protocol_tcp
    cidr_blocks = var.cidr_block
  }

  egress {
    from_port   = var.outbound_port
    to_port     = var.outbound_port
    protocol    = var.protocol_outbound
    cidr_blocks = var.cidr_block
  }

  tags = {
    Name = var.sg_tag
  }
}

#Create launch template
resource "aws_launch_template" "aws_lt" {
  name_prefix            = "AmazonLinux"
  image_id               = "ami-00beae93a2d981137"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  user_data              = filebase64(var.ud_filepath)
}

#Create autoscaling group
resource "aws_autoscaling_group" "aws_asg" {
  name                = "ApacheASG"
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = ["subnet-0c234b47e503eff16", "subnet-064ce0202f126bfec"]
  launch_template {
    id      = aws_launch_template.aws_lt.id
    version = "$Latest"
  }
}

#Create s3 bucket
resource "aws_s3_bucket" "Apache_Bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_tag
  }
}


