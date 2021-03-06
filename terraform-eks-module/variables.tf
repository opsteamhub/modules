variable "name" {}

variable "region" {}

variable "private_subnets_id" {
  type = list(string)
  default = []  
}

variable "public_subnets_id" {
  type = list(string)
  default = []  
}

variable "kubernetes_version" {
  default = "1.21"
}

variable "desired_size" {
  default = 3
}

variable "max_size" {
  default = 6
}

variable "min_size" {
  default = 3
}

variable "environment" {}

variable "ami_id" {
  description = "The AMI from which to launch the instance. If not supplied, EKS will use its own default image"
  type        = string
  default     = ""
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance(s) will be EBS-optimized"
  type        = bool
  default     = false
}

variable "endpoint_private_access" {
  default = false
}

variable "endpoint_public_access" {
  default = true
}

variable "provisioner" {
  default = "Terraform"
}

variable "tags" {
  default     = {}
  description = "adicional tags"
  type        = map(string)
}

variable "tag_private_subnet" {
  default = "private" 
}

variable "tag_public_subnet" {
  default = "public"  
}

variable "volume_size" {
  default = 10
}

variable "taints" {
  type = list(object({
    key     = optional(string)
    value   = optional(string)
    effect  = optional(string)
  }))
  default = []
}

variable "instance_type" {
  default = "t3.medium"
}

variable "scaling_config" {
  type = list(object({
    desired_size   = optional(number)
    min_size       = optional(number)
    max_size       = optional(number)
    instance_types = optional(string)
  }))
  default =  [
    {
    desired_size = 3
    min_size     = 3
    max_size     = 6
    }
  ]
}