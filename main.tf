resource "google_compute_instance" "oracle_db" {
  name         = "${var.environment}-oracle-db"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.os_image
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  attached_disk {
    type = "PERSISTENT"
    mode = "READ_WRITE"
    initialize_params {
      size  = var.db_storage_size
      type  = lower(var.db_storage_type) == "ssd" ? "pd-ssd" : lower(var.db_storage_type) == "balanced" ? "pd-balanced" : "pd-standard"
    }
    auto_delete = true
  }

  network_interface {
    network    = var.vpc_network
    subnetwork = var.subnet

    access_config {
      count = var.db_public_access_enabled ? 1 : 0
    }

    alias_ip_range {
      count = var.db_ip_range_allowed ? 1 : 0
      ip_cidr_range = "10.0.0.0/24" # puedes parametrizar esto si lo deseas
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    echo "Instalando Oracle..."
    # Aquí iría la lógica para instalar Oracle usando var.db_version, var.db_sid, etc.
    # Puedes usar scripts remotos o plantillas.
  EOT

  service_account {
    email  = var.iam_role
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
  }

  tags = ["oracle-db", var.environment]
}

resource "google_compute_disk" "oracle_data_disk" {
  name  = "${var.environment}-oracle-data-disk"
  type  = lower(var.db_storage_type) == "ssd" ? "pd-ssd" : lower(var.db_storage_type) == "balanced" ? "pd-balanced" : "pd-standard"
  zone  = var.zone
  size  = var.db_storage_size
}

resource "google_compute_instance_iam_member" "db_instance_role" {
  instance_name = google_compute_instance.oracle_db.name
  zone          = var.zone
  role          = "roles/compute.instanceAdmin.v1"
  member        = "serviceAccount:${var.iam_role}"
}
