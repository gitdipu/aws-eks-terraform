terraform {
  backend "s3" {
    bucket = "himansu-s3-tfstate"
    key    = "eks.tfstate"
    region = "us-east-1"
  }
}
