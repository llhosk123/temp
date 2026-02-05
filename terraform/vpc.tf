# VPC 조회
data "aws_vpc" "default" {
  default = true
}

# public subnet 수동 지정
data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}
