variable "node_groups" {
  type = map(object({
    instance_type = optional(string)
    volume_size   = optional(number)
    scaling_config = optional(list(object({
      desired_size  = optional(number)
      max_size      = optional(number)
      min_size      = optional(number) 
    })))
    taint = optional(list(object({
      key    = optional(string)
      value  = optional(string)
      effect = optional(string)
    })))
  }))
  default = {
    "key" = {
      instance_type = "t3.small"
      volume_size  = 10
      desired_size = 1
      max_size     = 1
      min_size     = 1         
    }
  }  
}

resource "aws_launch_template" "node" {
  for_each = var.node_groups

  name_prefix            = join("-", ["lt", var.environment, each.key])
  update_default_version = true

  ebs_optimized = var.ebs_optimized
  image_id      = var.ami_id

  instance_type = each.value["instance_type"]

  vpc_security_group_ids = [aws_security_group.node_group_sg[each.key].id]

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           =  each.value["volume_size"] == null ? var.volume_size : each.value["volume_size"]
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = format("%s-node-group", each.key)
    }
  }
}

#####

resource "aws_launch_template" "default_node" {

  name_prefix            = join("-", ["lt", local.name])
  update_default_version = true

  ebs_optimized = var.ebs_optimized
  image_id      = var.ami_id

  instance_type = var.instance_types

  vpc_security_group_ids = [aws_security_group.default_node_group_sg.id]

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = var.volume_size 
      delete_on_termination = true
      volume_type           = "gp2"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = format("%s-node-group", local.name)
    }
  }
}