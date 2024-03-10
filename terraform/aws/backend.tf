terraform {
  backend "s3" {
    bucket  = "my-terraform-tfstate-ap-northeast-1"
    region  = "ap-northeast-1"
    key     = "staging.tfstate"
    encrypt = true
  }
}
