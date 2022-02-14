resource "tls_private_key" "private_keys" {
  for_each = toset([for domain in var.domains : domain.name])

  algorithm = "RSA"
}

resource "acme_registration" "regs" {
  for_each = toset([for domain in var.domains : domain.name])

  account_key_pem = tls_private_key.private_keys[each.key].private_key_pem
  email_address   = var.email
}

resource "acme_certificate" "certificates" {
  for_each = { for domain in var.domains : domain.name => domain }

  account_key_pem           = acme_registration.regs[each.key].account_key_pem
  common_name               = each.value.name
  subject_alternative_names = each.value.subject_alternative_names

  dns_challenge {
    provider = "gcloud" # https://registry.terraform.io/providers/vancluever/acme/latest/docs/guides/dns-providers-gcloud

    config = {
      GCE_PROJECT              = var.project
      GCE_SERVICE_ACCOUNT_FILE = var.credentials
    }
  }
}