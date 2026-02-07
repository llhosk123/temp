# 원래는 k3s.yml이였던 것

# EC2에 k3s 설치용 Ansible Playbook

---
- name: Install K3s on EC2
  hosts: aws # inventory 그룹 이름
  become: yes # sudo 권한으로 명령 실행
  gather_facts: yes # Python 설치 후 facts(호스트 정보) 수집 가능

  tasks:
    # EC2에 Python 없으면 설치
    # -> 실무에서 여러 서버, 여러 번 playbook 재실행 가능성 고려하여 '없으면 설치'하는 방식 사용
    - name: Ensure Python3 is installed
      raw: |
        if ! command -v python3 >/dev/null 2>&1; then
          sudo dnf install -y python3
        fi
        
    - name: Install k3s
      shell: curl -sfL https://get.k3s.io | sh -
      args:
        executable: /bin/bash

    - name: Check k3s status
      shell: systemctl is-active k3s
      register: k3s_status
      changed_when: false
      failed_when: k3s_status.stdout.strip() != "active"
