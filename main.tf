provider "aws" {
  region = var.region
}

##########################################
# IAM assumable role with custom policies
##########################################
module "iam_assumable_role_custom" {
  source = "./modules/iam-assumable-role"

  create_role = true

  role_name         = var.role_name
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.iam_policy.arn
  ]
}



############
# IAM users
############
module "iam_user1" {
  source = "./modules/iam-user"

  name = "user1"

  create_iam_user_login_profile = false
  create_iam_access_key         = false
}


#####################################################################################
# IAM group for users with custom access
#####################################################################################
module "iam_group_with_custom_policies" {
  source = "./modules/iam-group-with-policies"

  name = var.group_name

  group_users = [
    module.iam_user1.iam_user_name
  ]

  custom_group_policies = [
    {
      name   = "AllowEC2Describe"
      policy = module.iam_policy.arn
    },
  ]
}


#########################################
# IAM policy
#########################################
module "iam_policy" {
  source = "./modules/iam-policy"

  name        = var.policy_name
  path        = "/"
  description = "CI Policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}