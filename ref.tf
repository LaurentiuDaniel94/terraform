terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
  access_key =  "AKIAZV4J7OK7UP2TF3HE"
  secret_key = "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"
}

resource "aws_eip" "myEip" {
    vpc = true
}

resource "aws_instance" "myEc2" {
  ami = "ami-0ca285d4c2cda3300"
  instance_type = "t2.micro"
}

resource "aws_eip_association" "eip_assic" {
  instance_id = aws_instance.myEc2.id
  allocation_id = aws_eip.myEip.id
}

resource "aws_security_group" "mySecGroup" {
  name = "my-security-group"


ingress {
    from_port = 433
    to_port = 433
    protocol = "tcp"
    cidr_blocks = ["${aws_eip.myEip.public_ip}/32"]
    }

}
