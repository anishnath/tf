locals {
  group_name = element(concat(aws_iam_group.this.*.id, [var.name]), 0)
}

resource "aws_iam_group" "this" {
  count = var.create_group ? 1 : 0

  name = var.name
}

resource "aws_iam_group_membership" "this" {
  count = length(var.group_users) > 0 ? 1 : 0

  group = local.group_name
  name  = var.name
  users = var.group_users
}



###############
# IAM policies
###############


resource "aws_iam_policy" "custom" {
  count = length(var.custom_group_policies)

  name        = var.custom_group_policies[count.index]["name"]
  policy      = var.custom_group_policies[count.index]["policy"]
  description = lookup(var.custom_group_policies[count.index], "description", null)

  tags = var.tags
}