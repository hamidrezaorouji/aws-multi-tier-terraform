terraform {
  backend "s3" {
    bucket         = ""  # von Skript erzeugt
    key            = "dev/terraform.tfstate"
    region         = ""
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

