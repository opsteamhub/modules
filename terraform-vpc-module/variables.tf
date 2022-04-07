variable "name" {}

variable "region" {}

variable "environment" {}

variable "cidr_block" {
  default = ""
}

variable "max_subnet_count" {
  default     = 0
  description = "Sets the maximum amount of subnets to deploy. 0 will deploy a subnet for every provided availablility zone (in `availability_zones` variable) within the region"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of Availability Zones where subnets will be created"

  validation {
    condition     = length(var.availability_zones) > 0
    error_message = "Availability zones must be greater than zero."
  }
}

variable "owner" {
  default = "OpsTeam"
}

variable "provisioner" {
  default = "Terraform"

}

variable "tags" {
  default     = {}
  description = "adicional tags"
  type        = map(string)
}

variable "routes" {
  type = list(object({
    transit_gateway_id        = optional(string)
    vpc_peering_connection_id = optional(string)
    cidr_block                = optional(string)
    gateway_id                = optional(string)
    nat_gateway_id            = optional(string)
    network_interface_id      = optional(string)
  }))
  default = []
}

variable "new_bit" {
  type = number
  default = 4
}