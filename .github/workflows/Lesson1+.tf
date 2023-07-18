provider "aws" {
region = "eu-central-1"
}

resource "aws_lb" "wordpress" {
  name               = "wordpress-lb-tf"
  internal           = false
  load_balancer_type = "application"
  
  
  enable_deletion_protection = false

  access_logs {
    bucket  = load-balancer-wordpress
    prefix  = "wordpress-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}




resource "aws_instance" "my_webserver1" {
ami        = "ami-0499632f10efc5a62"
instance_type = "t3.micro"
vpc_security_group_ids = [aws_security_group.WebServer.id]
}

resource "aws_instance" "my_webserver2" {
ami        = "ami-0499632f10efc5a62"
instance_type = "t3.micro"
vpc_security_group_ids = [aws_security_group.WebServer.id]
}


resource "aws_security_group" "WebServer" {
  name        = "WebServer Security Group"
  description = "First Security Group"
  

  ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}