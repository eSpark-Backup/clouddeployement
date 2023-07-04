# How to add Github account in AWS-Linux
## Step 1: Log in to AWS console then generate ssh key
  - ![img](./img/9-a.png)
  - cd ~/.ssh/
  - ssh-keygen -o -t rsa -C "email@email.com"
  - cat ~/.ssh/id_rsa.pub
## Step 2: Log in to github via web-browser then locate the setting
  - ![img](./img/10.png)
  - ![img](./img/11.png)
  - ![img](./img/12.png)
  - ![img](./img/12-a.png)
## Step 3: Clone Required repo
  - ![img](./img/13.png)
  - Change/crete directory
  - ![img](./img/14.png)
- For more info 
https://jdblischak.github.io/2014-09-18-chicago/novice/git/05-sshkeys.html
