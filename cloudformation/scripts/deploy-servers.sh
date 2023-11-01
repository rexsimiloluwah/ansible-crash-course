#!/bin/bash 

STACK_NAME=ansible-crash-course-vms
REGION=us-west-2
AWS_CLI_PROFILE=theblkdv
EC2_INSTANCE_TYPE=t2.micro
KEY_PAIR_NAME=ansible

# Deploy the EC2 instances
aws cloudformation deploy \
  --region $REGION \
  --profile $AWS_CLI_PROFILE \
  --stack-name $STACK_NAME \
  --template-file cloudformation/main.yml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides InstanceType=$EC2_INSTANCE_TYPE \
      KeyName=$KEY_PAIR_NAME

# Output the public IPs of the created instances, if successful
if [ $? -eq 0 ]; then 
  aws cloudformation list-exports \
    --profile $AWS_CLI_PROFILE \
    --query "Exports[?starts_with(Name, 'AnsibleEC2Instance')].Value" \
    --region $REGION
fi
