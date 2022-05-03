### Terraform EKS Module


##### main.tf
```
variable "name" {}
variable "region" {}
variable "environment" {}
variable "tag_private_subnet" {}

module "eks" {
  source             = "github.com/opsteamhub/modules/tree/master/terraform-eks-module"
  name               = var.name
  region             = var.region
  environment        = var.environment   
  tag_private_subnet = var.tag_private_subnet
}
```

##### variable.tfvars

```
name               = "name_cluster"
region             = "aws_region"
environment        = "production or staging"
tag_private_subnet = "private or public"
```