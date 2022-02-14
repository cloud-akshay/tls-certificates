project     = "<Google cloud project ID>"
credentials = "<the path to service account key file>"
email       = "<your email id>"
domains = [
  {
    name                      = "<your-domain.com>"
    subject_alternative_names = ["www.<your-domain.com>"]
  }
]