terraform {
  required_version = "~> 0.14"

  required_providers {
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
    tls = {
      version = "~> 3.0"
    }
  }
}
