# How to udpate AWS-deployment
## Step 1: Log in to AWS console via web or ssh
  - https://console.aws.amazon.com/console/home?nc2=h_ct&src=header-signin
  - for user name password (contact admin) 
## Step 2: Access EC2 instance (for web only)
  - ![img](./img/1.png)
  - ![img](./img/2.png)
  - ![img](./img/3.png)
  - ![img](./img/4.png)
  - ![img](./img/5.png)
## Step 3: checkout latest branch
  - ![img](./img/6.png)
  - [how to add github account](#how-to-add-github-account-in-aws-linux)
## Step 4: Build and deploy 
  - ![img](./img/7.png)
  - yarn run deploy:prod
  - if any package like "passport" is not found, just add it using npm install command
  - ![img](./img/8.png)
## Result
https://dev.koing.ai/