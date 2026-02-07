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
resource "aws_instance" "k3s_node" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.small"
  key_name      = "infra-dev-key"

  # public subnet 중 첫 번째에 배치
  subnet_id = data.aws_subnets.public.ids[0]

  vpc_security_group_ids = [
    aws_security_group.sg_7th_room.id,
    aws_security_group.web-sg.id
  ]

  tags = {
    Name = "dev-k3s-node-01"
    Environment = "dev"
    Project = "infra-auto"
  }
}

output "public_ip" {
  value = aws_instance.k3s_node.public_ip
}
