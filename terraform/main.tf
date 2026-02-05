# public ip 자동 할당(associate_public_ip_address) 기본값 true이기 때문에 생략

# region
provider "aws" {
  region = "ap-northeast-2"
}

# ami
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  owners = ["amazon"]
}

# terraform resource
# 기본 VPC 첫 번째 public subnet에 자동 배치
resource "aws_instance" "k3s_node" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name      = "infra-dev-key"
  vpc_security_group_ids = [aws_security_group.sg_7th_room.id]

  tags = {
    Name = "dev-k3s-node-01"
    Environment = "dev"
    Project = "infra-auto"
  }
}

output "public_ip" {
  value = aws_instance.k3s_node.public_ip
}
