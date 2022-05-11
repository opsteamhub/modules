### Terraform EKS Module


##### main.tf
```
variable "name" {}
variable "region" {}
variable "environment" {}
variable "tag_private_subnet" {}
variable "node_groups" {}

module "eks" {
  source             = "github.com/opsteamhub/modules/tree/master/terraform-eks-module"
  name               = var.name
  region             = var.region
  environment        = var.environment   
  tag_private_subnet = var.tag_private_subnet
  node_groups        = var.node_groups
}
```

##### variable.tfvars

```
name               = "name_cluster"
region             = "aws_region"
environment        = "production or staging"
tag_private_subnet = "private or public"

node_groups = {
                default-node-group = {} 

                elasticsearch = {
                    instance_type  = "t3.micro"
                    volume_size    = 40
                    taint          = [ 
                                       {
                                         key    = "elasticsearch"
                                         value  = "true"
                                         effect = "NO_SCHEDULE"
                                       }                           
                    ]
                    scaling_config = [
                                       {
                                         desired_size = 3
                                         min_size     = 3
                                         max_size     = 6
                                        }
                    ]                                         
                }                  
              }

```