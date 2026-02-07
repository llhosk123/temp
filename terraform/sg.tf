# 서울 리전 기본 VPC: 172.31.0.0/16
# 외부 공개 포트: 80/443
# 내부/관리 포트: 22, 3000, 6443 -> VPC 내부만 허용

# sg 2개 분리해서 붙이는 구조 (관리용(SSH) / 서비스용(웹/클러스터) 역할 분리)

# sg 생성
resource "aws_security_group" "sg_7th_room" {
    vpc_id = data.aws_vpc.default.id # 기본 VPC에 생성

  ingress { # 인바운드                           
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # cidr_blocks = ["218.39.98.40/32"] # 관리자 IP만 허용
    cidr_blocks = ["0.0.0.0/0"] # CI/CD용
  }

  egress { # 아웃바운드                          
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # 모든 프로토콜
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_7th_room"
    Environment = "dev"
    Project = "infra-auto"
  }
}

# web server sg (클러스터 내부 통신)
resource "aws_security_group" "web-sg" {
    vpc_id = data.aws_vpc.default.id

  # HTTP/HTTPS (ModSecurity(= WAF) 입구)
  # WAF는 80/443 포트로 들어오는 웹 트래픽만 검사
  # VPC 내부 (공격 시연): 공격자 EC2 -> 80 -> WAF 차단
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    # cidr_blocks = ["10.0.0.0/16"] # 내부에서 오는 트래픽 허용? 기본 VPC랑 범위가 안맞음
    cidr_blocks = ["0.0.0.0/0"] # 실무에서는 외부 전체 허용이 표준
    # cidr_blocks = [data.aws_vpc.default.cidr_block] # VPC 내부 공격 시연 시 (실습용) - 외부 웹 서비스 불가
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # K3s API 서버
  ingress {
    from_port       = 6443
    to_port         = 6443
    protocol        = "tcp"
    # security_groups = [aws_security_group.sg_7th_room.id] # ?
    self            = true # 같은 sg끼리 모든 통신 허용 (K3s 노드들이 같은 sg 사용) -> 우리는 EC2 하나니까 자기 자신 통신만 허용 (EC2가 1대로 안할거면 수정해야 함)
  }

  # K3s Flannel CNI (노드 간 모든 통신 허용)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  tags = {
    Name = "web-sg"
    Environment = "dev"
    Project = "infra-auto"
  }
}
