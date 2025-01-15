terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.16.0" # Replace with the latest version
    }
  }
}

# Configure the Google Cloud provider
provider "google" {
  project = "replix-394315"  # Replace with your project ID
  region  = "us-central1"
  zone    = "us-central1-c"
}


# Use the reserved external IP address
resource "google_compute_address" "static_ip" {
  name   = "static-ip"
  region = "us-central1"
}

# Create a Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "awesome-instance"
  machine_type = "e2-micro"  # Free Tier eligible machine type
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2004-lts"  # Latest Ubuntu LTS image
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.static_ip.address
      # Uncomment this if you want to use a static IP address
      # nat_ip = "35.208.129.42"
      network_tier = "STANDARD"
    }
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  scheduling {
    preemptible       = false
    automatic_restart = true
  }

  labels = {
    environment = "free-tier"
  }
}

output "instance_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}