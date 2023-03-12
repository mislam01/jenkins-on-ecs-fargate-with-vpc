# jenkins-on-ecs-fargate-with-vpc

### Create Backend:
1. Update the values in `example/init.confi` and `init.auto.tfvars` making sure the `bucket`, `key`, `lock table` and the `region` names are the same on both files.
2. On the terminal, move to `example/bootstrap` folder.
3. Run `deploy_bootstrap.sh` script to create the backend resources in AWS.

### Deploy Jenkins (for now only VPC.)
1. Update the values in `example/terraform.tfvars` file. Make sure to keep the same region as you used for Backend.
2. On the terminal, move to `example` folder.
3. Run `deploy_example.sh` script.





Help: 
1. https://aws.amazon.com/blogs/devops/building-a-serverless-jenkins-environment-on-aws-fargate/
2. https://github.com/aws-samples/serverless-jenkins-on-aws-fargate

