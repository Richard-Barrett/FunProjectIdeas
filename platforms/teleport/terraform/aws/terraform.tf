terraform {
  backend "s3" {
    bucket = "terraform-teleport"
    key = "terraform-teleport.tfstate"
    region = "us-east-1"
  }
}

provider "kubernetes" {
  config_path = "kube.yml"
  config_context = "default"
}

provider "aws" {
  region = "us-east-1"
}