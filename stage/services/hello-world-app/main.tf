provider "aws" {
  region = "us-east-2"
}

module "hello_world_app" {
  source = "../../../modules/services/hello-world-app"

  environment            = "stage"
  db_remote_state_bucket = "terraform-up-and-running-state-pmcg"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 2
  enable_autoscaling = false
}

terraform {
  backend "s3" {
    bucket         = "terraform-up-and-running-state-pmcg"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-up-and-running-locks"
    encrypt        = true
  }
}
