resource "aws_security_group" "create_sg" {
  name        = "Test"
  description = "Test"
  vpc_id      = "vpc-17"
  tags        = var.tags

  //revoke_rules_on_delete = var.revoke_rules_on_delete

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      cidr_blocks      = lookup(ingress.value, "cidr_block", [])
      description      = lookup(ingress.value, "description", null)
      from_port        = lookup(ingress.value, "from_port", null)
      ipv6_cidr_blocks = lookup(ingress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(ingress.value, "prefix_list_ids", null)
      protocol         = lookup(ingress.value, "protocol", null)
      security_groups  = lookup(ingress.value, "security_groups", [])
      self             = lookup(ingress.value, "self", null)
      to_port          = lookup(ingress.value, "to_port", null)
    }
  }

  dynamic "egress" {
    for_each = var.egress_rules
    content {
      cidr_blocks      = lookup(egress.value, "cidr_block", null)
      description      = lookup(egress.value, "description", null)
      from_port        = lookup(egress.value, "from_port", null)
      ipv6_cidr_blocks = lookup(egress.value, "ipv6_cidr_blocks", null)
      prefix_list_ids  = lookup(egress.value, "prefix_list_ids", null)
      protocol         = lookup(egress.value, "protocol", null)
      security_groups  = lookup(egress.value, "security_groups", null)
      self             = lookup(egress.value, "self", null)
      to_port          = lookup(egress.value, "to_port", null)
    }
  }
}



variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = list(string)
      security_groups = list(string)
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = ["1.2.3.4/32"]
          description = "test"
          security_groups = []
        },
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = ["1.2.3.4/32"]
          description = "test"
          security_groups = []
        },
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = []
          security_groups  = ["sg-003"]
          description = "test"
        },

    ]
}


variable "egress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = list(string)
      security_groups = list(string)
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = ["1.2.3.4/32"]
          description = "test"
          security_groups = []
        },
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = ["1.2.3.4/32"]
          description = "test"
          security_groups = []
        },
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = []
          security_groups  = ["sg-00343"]
          description = "test"
        },

    ]
}


variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {
    "Name" : "anish-sg-demo",
    "test" : "anish"

  }
}
