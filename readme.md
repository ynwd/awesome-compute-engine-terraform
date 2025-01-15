# Awesome Compute Engine Terraform

This Terraform will create a GCP Compute Engine instance.

```bash
# login to gcloud
gcloud auth application-default login

# init
terraform init

# build
terraform apply
```

## The Highlighted Block

```bash
# Configure the Google Cloud provider
provider "google" {
  project = "replix-394315"  # Replace with your project ID
  region  = "us-central1"
  zone    = "us-central1-c"
}
```

```bash
  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static_ip.address
      # Uncomment and replace this if you want to use your own static IP address
      # nat_ip = "35.208.129.42"
      network_tier = "STANDARD"
    }
  }
```