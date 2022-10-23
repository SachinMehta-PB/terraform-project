terraform {
  backend "s3" {
    bucket = "terraform-project-statestore"
    key = "terraform/backend"
    region = "us-east-2"
  }
}