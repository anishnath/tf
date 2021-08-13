variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "1.2.3.4/32"
          description = "test"
        },
        {
          from_port   = 23
          to_port     = 23
          protocol    = "tcp"
          cidr_block  = "1.2.3.4/32"
          description = "test"
        },
    ]
}

resource "aws_security_group_rule" "ingress_rules_test" {


  count = length(var.ingress_rules)

  type              = "ingress"
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = [var.ingress_rules[count.index].cidr_block]
  description       = var.ingress_rules[count.index].description
  security_group_id = "vpc-17ba956d"
}
