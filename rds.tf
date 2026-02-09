#rds.tf
# Variables

variable "vpc_id" {
  description = "VPC ID"
}

variable "private_subnet_ids" {
  description = "Private subnet IDs (2개 이상, 서로 다른 AZ)"
  type        = list(string)
}

variable "db_username" {
  description = "RDS master username"
}

variable "db_password" {
  description = "RDS master password"
  sensitive   = true
}

# Web Security Group (EC2 / k3s)

resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web-sg"
  }
}

# RDS Security Group

resource "aws_security_group" "rds_sg" {
  name   = "admin-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "admin-rds-sg"
  }
}


# RDS Subnet Group

resource "aws_db_subnet_group" "rds_subnet" {
  name       = "admin-rds-subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "admin-rds-subnet"
  }
}

# RDS Instance (Free Tier Safe)

resource "aws_db_instance" "admin_db" {
  identifier = "admin-db"

  # Free Tier 핵심
  engine         = "mysql"
  engine_version = "8.0.36"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  storage_type      = "gp2"
  db_name           = "admindb"

  username = var.db_username
  password = var.db_password

  # 안전 설정
  publicly_accessible     = false
  multi_az                = false
  deletion_protection     = false   # 실습용 (필요 시 true)
  skip_final_snapshot     = true
  backup_retention_period = 7

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.rds_subnet.name

  tags = {
    Name = "admin-rds"
    Env  = "free-tier"
  }
}


# Outputs

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.admin_db.address
}

output "rds_db_name" {
  value = aws_db_instance.admin_db.db_name
}
