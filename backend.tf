terraform {
  backend "local" {
    path = "<relative/path/to/terraform.tfstate>"
  }
  # Note: It is not recommended to use local as backend in a production environment.
}