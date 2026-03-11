data "terraform_remote_state" "rg" {
  backend = "local"

  config = {
    path = "../rg/terraform.tfstate"
  }
}

data "terraform_remote_state" "storage" {
  backend = "local"

  config = {
    path = "../storage/terraform.tfstate"
  }
}