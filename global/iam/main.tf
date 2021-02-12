provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-state-pmcg"
    key            = "global/iam/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}

variable "user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default = [
    "neo",
    "trinity",
  "morpheus"]
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name     = each.value
}
