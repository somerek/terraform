terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Owner = var.owner
    }
  }
}

module "ec2" {
  source = "./modules/ec2"
}

resource "aws_db_instance" "terraform_course_rds" {
  # final_snapshot_identifier = "test"
  allocated_storage      = 10
  identifier             = "my-db"
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  db_name                = "mydb"
  username               = var.my_username
  password               = var.my_password
  vpc_security_group_ids = [aws_security_group.sg_db.id]
  # backup_retention_period =0
  skip_final_snapshot = true
}
resource "aws_security_group" "sg_db" {
  name        = "sg_db"
  description = "sg for RDS"
  ingress {
    description = "mysql"
    from_port   = 3306
    to_port     = 3306
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
