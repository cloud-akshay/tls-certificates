output "tls_certs" {
  sensitive = true

  value = { for domain, cert in acme_certificate.certificates : domain =>
    {
      private_key = cert.private_key_pem
      certificate = "${cert.certificate_pem}${cert.issuer_pem}"
    }
  }
  description = "The certificates and privates key in PEM format"
}
