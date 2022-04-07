## Terraform VPC Module

### Resources Provisionados
* VPC
* Subnets
* Internet Gateway
* Nat Gateway
* Route Table
* Elastic IP

##### Default Create subnets /22
##### Para criar outros Cidrs, alterar o newbit de acordo com a documentação da function cidrsubnet https://www.terraform.io/language/functions/cidrsubnet

##### Exemplo adicionando tags e adicionando rotas na route table

```
variable "name" {}
variable "environment" {}
variable "region" {}
variable "cidr_block" {}
variable "availability_zones" {}
variable "tags" {}
variable "routes" {}

module "vpc" {
  source             = "github.com/opsteamhub/terraform-vpc-module.git"
  name               = var.name
  environment        = var.environment
  region             = var.region
  cidr_block         = var.cidr_block
  availability_zones = var.availability_zones
  tags               = var.tags
  routes             = var.routes 
}

```
##### variables.tfvars
```
environment = "environment"
cidr_block = ""
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

tags = {
    key = "value"
}

routes   = [
              {
               cidr_block = "",c
               transit_gateway_id = "tgw-xxxxxxxxx"      
              }
            ]

```