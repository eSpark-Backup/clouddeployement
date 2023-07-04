# How to access ec2 running instance from windows powershell via ssh
## Windows side
- Launch Powershell 
```console
ssh-keygen -b 4096
```
- generate key, enter phrase then save with any [ssh key filename].
```console
notepad C:\Users\[username]\.ssh\[ssh key filename like id_rsa.pub]
```
- Copy public key

## EC2 side
- launch ssh of ec2 insatnce via aws webconsole 
```console
sudo nano authorized_keys
```
- paste public key then save it
```console
exit
```

- from ec2 dashboard Click instance-->connect-->ssh
- copy ssh link eg: "ssh -i "koing-dev.pem" ubuntu@ec2-15-165-156-115.ap-northeast-2.compute.amazonaws.com"

## Windows side
- Launch powershell
- Paste ssh link 
- Replace "koing-dev.pem" with your [ssh key filename] 
```console 
ssh -i C:\Users[username]\.ssh\[ssh key file name] ubuntu@ec2-15-165-156-115.ap-northeast-2.compute.amazonaws.com
```
- For exit 
```console
exit
```