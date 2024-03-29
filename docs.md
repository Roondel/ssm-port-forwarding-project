## Linux/Mac
aws ssm start-session --region us-east-1 \
--target $(aws ec2 describe-instances --filters "Name=tag:Name,Values=bastion_host_rds" --query "Reservations[*].Instances[*].InstanceId" --output text --region us-east-1) \
--document-name AWS-StartPortForwardingSessionToRemoteHost \
--parameters '{"portNumber":["5432"], "localPortNumber":["12345"], "host":['"$(aws rds describe-db-instances --db-instance-identifier postgresql --query "DBInstances[*].Endpoint.Address" --output text --region us-east-1)"']}'


## Windows
aws ssm start-session --region us-east-1 --target $(aws ec2 describe-instances --filters "Name=tag:Name,Values=bastion_host_rds" "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].InstanceId" --output text --region us-east-1) --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters portNumber="5432",localPortNumber="12345",host="$(aws rds describe-db-instances --db-instance-identifier postgresql --query "DBInstances[*].Endpoint.Address" --output text --region us-east-1)"


## Resources
- https://docs.aws.amazon.com/systems-manager/latest/userguide/quick-setup-host-management.html
- https://docs.aws.amazon.com/systems-manager/latest/userguide/setup-create-vpc.html#sysman-setting-up-vpc-create