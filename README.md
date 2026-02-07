### Actions 성공 후 k3s active 확인 완료 (2026.02.07)
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
       Docs: https://k3s.io
    Process: 4631 ExecStartPre=/sbin/modprobe br_netfilter (code=exited, status=0/SUCCESS)
    Process: 4632 ExecStartPre=/sbin/modprobe overlay (code=exited, status=0/SUCCESS)
   Main PID: 4633 (k3s-server)
      Tasks: 101
     Memory: 509.8M
        CPU: 54.986s
     CGroup: /system.slice/k3s.service
             ├─4633 "/usr/local/bin/k3s server"
             ├─4857 "containerd "
             ├─5670 /var/lib/rancher/k3s/data/ffd82c56f7aadb3263c7708547a6027705a0eb9a638534465002ba309cae9990/bin/cont>
             ├─5672 /var/lib/rancher/k3s/data/ffd82c56f7aadb3263c7708547a6027705a0eb9a638534465002ba309cae9990/bin/cont>
             ├─5674 /var/lib/rancher/k3s/data/ffd82c56f7aadb3263c7708547a6027705a0eb9a638534465002ba309cae9990/bin/cont>
             ├─5675 /var/lib/rancher/k3s/data/ffd82c56f7aadb3263c7708547a6027705a0eb9a638534465002ba309cae9990/bin/cont>
             └─5679 /var/lib/rancher/k3s/data/ffd82c56f7aadb3263c7708547a6027705a0eb9a638534465002ba309cae9990/bin/cont>

Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.218318    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.259848    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.402553    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.478616    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.681868    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.681922    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.779337    4633 handler.go:285>
Feb 07 12:32:59 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:32:59.931864    4633 handler.go:285>
Feb 07 12:33:00 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:33:00.701737    4633 event.go:389] >
Feb 07 12:33:00 ip-172-31-56-95.ap-northeast-2.compute.internal k3s[4633]: I0207 12:33:00.727164    4633 event.go:389] >
```
