terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.20.0"
    }
  }
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "isaacweathersnet"
    workspaces {
      name = "basic-training"
    }
  }

}

provider "aws" {
  region = "us-west-2"
}
resource "aws_instance" "example" {
  ami = "ami-ofb653ca2d3203ac1"
  instance_type = "t2.micro"
  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "terraform-example"
  }
  user_data_replace_on_change = true

}