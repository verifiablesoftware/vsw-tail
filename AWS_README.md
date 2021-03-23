# AWS

a step-by-step instructions to get vsw-tails running in AWS
requires AWS account and ECR and EC2


## how to 

### 1 -- Build docker image

create docker image e.g. in this case vsw-tails

```
docker build -f ./docker/dockerfile.aws -t vsw-tails .
```

### 2 --  Change the tag to AWS tag

docker image has to be named this way

```
docker tag docker_tails-server:latest 971700601135.dkr.ecr.us-east-2.amazonaws.com/vsw-tails:latest
```

### 3 --  login to AWS

in linux this should work. In win WSL, it did not but this can be used later to generate password in EC2.
user has to log to right AWS region in order this (push image to ECR) to work.


```
docker login -u AWS 971700601135.dkr.ecr.us-east-2.amazonaws.com
```

in WIN, used this command
```
(Get-ECRLoginCommand).Password | docker login --username AWS --password-stdin https://971700601135.dkr.ecr.us-east-2.amazonaws.com
```

### 4 -- Push it to registry

How to push docker image to AWS private registry after docker login is ok and a suitable registry is created.
Can be done from console or in visual studio code AWS extension if not done already

https://_aws-region_.console.aws.amazon.com/ecr/repositories

where _aws-region_ is e.g. _us-west-2_

```
docker push 971700601135.dkr.ecr.us-east-2.amazonaws.com/vsw-tails:latest
```
### 6 -- Login to EC2

access the EC2 instance 

### 7 -- Login to docker private registry
from the EC2 to pull right docker image

```
docker login -u AWS 971700601135.dkr.ecr.us-east-2.amazonaws.com
```
user is propted a password, copy/paste that from command
```
aws ecr get-login-password --region us-east-2
```

### 8 -- Pull docker image from ECR to EC2
```
docker pull 971700601135.dkr.ecr.us-east-2.amazonaws.com/vsw-tails
```

### 9 -- run docker image in EC2

use e.g. following command

```
docker run -d --name vsw-tails -p 6543:6543  971700601135.dkr.ecr.us-east-2.amazonaws.com/vsw-tails
```

#### other issues

AWS console e.g. 
https://us-east-2.console.aws.amazon.com/console/home?region=us-east-2

if you want to push docker image to ECR, you have to have logged in to right region.
region can be checked by

```
aws configure
```

to get the password 
```
 aws ecr get-login-password --region us-east-2
```
