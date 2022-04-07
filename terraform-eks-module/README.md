### Terraform EKS Module


##### main.tf
```
variable "name" {}
variable "region" {}
variable "private_subnets_id" {}
variable "vpc_id" {}
variable "environment" {}

module "eks" {
  source             = "github.com/opsteamhub/modules/tree/master/terraform-eks-module"
  name               = var.name
  region             = var.region
  private_subnets_id = var.private_subnets_id
  vpc_id             = var.vpc_id
  environment        = var.environment   
}
```

##### variable.tfvars

```
name               = "name_cluster"
region             = "aws_region"
private_subnets_id = ["subnet-xxxxxx", "subnet-xxxxxx", "subnet-xxxxxx"]
vpc_id             = "vpc-xxxxx"
environment        = "dev"
```