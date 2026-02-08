terraform {
  backend "s3" {
    bucket         = "3body-bucket" # REPLACE THIS WITH YOUR ACTUAL BUCKET NAME
    key            = "eks-platform/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
  }
}
