variable "region_name" {
  type    = string
  default = "us-east-1"
}

variable "sg_name" {
  type    = string
  default = "Apache SG"
}

variable "vpc_id" {
  type    = string
  default = "vpc-00bdbfa80f37bd0fe"
}

variable "ssh_desc" {
  type    = string
  default = "SSH"
}

variable "http_desc" {
  type    = string
  default = "HTTP"
}

variable "ssh_port" {
  type    = number
  default = 22
}

variable "http_port" {
  type    = number
  default = 80
}


variable "outbound_port" {
  type    = number
  default = 0
}

variable "protocol_tcp" {
  type    = string
  default = "tcp"
}

variable "protocol_outbound" {
  type    = string
  default = "-1"
}

variable "cidr_block" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

variable "sg_tag" {
  type    = string
  default = "TF_SG"
}

variable "bucket_name" {
  type    = string
  default = "my-tf-apache-bucket-may-2024-i382k4m2l"
}

variable "bucket_tag" {
  type    = string
  default = "Apache Buckets"
}

variable "ami_id" {
  type    = string
  default = "ami-00beae93a2d981137"
}

variable "instance_type_name" {
  type    = string
  default = "t2.micro"
}

variable "lt_name" {
  type    = string
  default = "AmazonLinux"
}

variable "ud_filepath" {
  type    = string
  default = "~/environment/terraform-project-week22/user-data.sh"
}

variable "asg_name" {
  type    = string
  default = "ApacheASG"
}

variable "max_instance" {
  type    = number
  default = 5
}

variable "min_instance" {
  type    = number
  default = 2
}

variable "subnet_id_A" {
  type    = string
  default = "subnet-0c234b47e503eff16"
}

variable "subnet_id_B" {
  type    = string
  default = "subnet-064ce0202f126bfec"
}

variable "version_type" {
  type    = string
  default = "$Latest"
}
