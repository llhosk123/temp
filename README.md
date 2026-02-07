## 트러블슈팅
[![Notion](https://img.shields.io/badge/Notion-black?style=for-the-badge&logo=notion&logoColor=white)](https://www.notion.so/300cd1e77d158071aab7da50eb155ad3)

## Actions 성공 후 k3s active 확인 완료 (2026.02.07)
```bash
Windows PowerShell
Copyright (C) Microsoft Corporation. All rights reserved.

새로운 기능 및 개선 사항에 대 한 최신 PowerShell을 설치 하세요! https://aka.ms/PSWindows

PS C:\Users\user> ssh -i "C:\Users\user\Downloads\infra-dev-key.pem" ec2-user@퍼블릭 IPv4 주소
   ,     #_
   ~\_  ####_
  ~~  \_#####\
  ~~     \###|
  ~~       \#/ ___   Amazon Linux 2023 (ECS Optimized)
   ~~       V~' '->
    ~~~         /
      ~~._.   _/
         _/ _/
       _/m/'

For documentation, visit http://aws.amazon.com/documentation/ecs
Last login: Sat Feb  7 12:26:58 2026 from 52.159.243.16
[ec2-user@ip-172-31-56-95 ~]$ sudo systemctl status k3s
● k3s.service - Lightweight Kubernetes
     Loaded: loaded (/etc/systemd/system/k3s.service; enabled; preset: disabled)
     Active: active (running) since Sat 2026-02-07 12:26:55 UTC; 6min ago
     ...
```
