
output "instance_name" {
  description = "Nombre de la instancia de Oracle"
  value       = google_compute_instance.oracle_db.name
}

output "instance_ip" {
  description = "Dirección IP externa de la instancia"
  value       = google_compute_instance.oracle_db.network_interface[0].access_config[0].nat_ip
  condition   = var.db_public_access_enabled
}

output "internal_ip" {
  description = "Dirección IP interna de la instancia"
  value       = google_compute_instance.oracle_db.network_interface[0].network_ip
}

output "boot_disk" {
  description = "Nombre del disco de arranque"
  value       = google_compute_instance.oracle_db.boot_disk[0].device_name
}

output "data_disk" {
  description = "Nombre del disco de datos"
  value       = google_compute_disk.oracle_data_disk.name
}
