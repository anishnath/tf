variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}
variable "group_name" {
  description = "Group Name"
  type        = string
  default     = ""
}
variable "role_name" {
  description = "Role Name"
  type        = string
  default     = ""
}
variable "policy_name" {
  description = "Policy Name"
  type        = string
  default     = ""
}