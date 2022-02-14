<!-- BEGIN_TF_DOCS -->
# TLS Certificates

A terraform root module to manage lifecycle of TLS certificates using Let's Encrypt

## How to read certificate values

Use `terraform_remote_state` resource to read certicates and its private keys.

Example:

```hcl
data "terraform_remote_state" "tls_certs" {
  backend = "local"

   config = {
    path = "<relative path to terraform.tfstate of this root module>"
  }
}

resource "google_compute_ssl_certificate" "certificate" {
  name_prefix = "certificate-server"

  private_key = data.terraform_remote_state.tls_certs.outputs.tls_certs["<your-domain.com>"].private_key
  certificate = data.terraform_remote_state.tls_certs.outputs.tls_certs["<your-domain.com>"].certificate

  lifecycle {
    create_before_destroy = true
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 0.14 |
| <a name="requirement_acme"></a> [acme](#requirement\_acme) | ~> 2.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_acme"></a> [acme](#provider\_acme) | 2.8.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 3.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [acme_certificate.certificates](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/certificate) | resource |
| [acme_registration.regs](https://registry.terraform.io/providers/vancluever/acme/latest/docs/resources/registration) | resource |
| [tls_private_key.private_keys](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_credentials"></a> [credentials](#input\_credentials) | Either the path to or the contents of a service account key file in JSON format | `string` | n/a | yes |
| <a name="input_domains"></a> [domains](#input\_domains) | The domains that this certificate will be recognized for | <pre>list(object({<br>    name                      = string<br>    subject_alternative_names = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_email"></a> [email](#input\_email) | The contact email address for the account | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the DNS zone belongs | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tls_certs"></a> [tls\_certs](#output\_tls\_certs) | The certificates and privates key in PEM format |
<!-- END_TF_DOCS -->