variable "project" {
  type        = string
  description = "The ID of the project in which the DNS zone belongs"
}

variable "credentials" {
  type        = string
  description = "Either the path to or the contents of a service account key file in JSON format"
}

variable "email" {
  type        = string
  description = "The contact email address for the account"
}

variable "domains" {
  type = list(object({
    name                      = string
    subject_alternative_names = list(string)
  }))
  description = "The domains that this certificate will be recognized for"
}
