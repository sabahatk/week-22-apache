#Set terraform providers
terraform {
  backend "s3" {
    bucket = "my-tf-apache-bucket-may-2024-i382k4m2l"
    key    = "project/backend-s3"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


provider "aws" {
  region = var.region_name
}

#Add security group to allow port 22 and 8080 traffic
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


resource "aws_launch_template" "aws_lt" {
  name_prefix            = var.lt_name
  image_id               = var.ami_id
  instance_type          = var.instance_type_name
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  user_data              = filebase64(var.ud_filepath)
}

resource "aws_autoscaling_group" "aws_asg" {
  name                = var.asg_name
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = [var.subnet_id_A, var.subnet_id_B]
  launch_template {
    id      = aws_launch_template.aws_lt.id
    version = var.version_type
  }
}

#create s3 bucket
resource "aws_s3_bucket" "Apache_Bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_tag
  }
}

