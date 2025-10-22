output "instance_name" {
  description = "Nombre de la instancia de base de datos Oracle"
  value       = google_sql_database_instance.oracle_db.name
}

output "connection_name" {
  description = "ID de conexión de la instancia de Cloud SQL"
  value       = google_sql_database_instance.oracle_db.connection_name
}

output "public_ip_address" {
  description = "Dirección IP pública de la instancia (si está habilitada)"
  value       = google_sql_database_instance.oracle_db.public_ip_address
  sensitive   = true
}

output "private_ip_address" {
  description = "Dirección IP privada de la instancia"
  value       = google_sql_database_instance.oracle_db.private_ip_address
  sensitive   = true
}

output "self_link" {
  description = "URL de referencia de la instancia"
  value       = google_sql_database_instance.oracle_db.self_link
}

output "server_ca_cert" {
  description = "Información del certificado CA del servidor"
  value       = google_sql_database_instance.oracle_db.server_ca_cert
  sensitive   = true
}

output "service_account_email" {
  description = "Email de la cuenta de servicio utilizada por la instancia"
  value       = google_sql_database_instance.oracle_db.service_account_email_address
}

output "backup_configuration" {
  description = "Configuración de respaldo de la instancia"
  value = {
    enabled          = google_sql_database_instance.oracle_db.settings[0].backup_configuration[0].enabled
    start_time      = google_sql_database_instance.oracle_db.settings[0].backup_configuration[0].start_time
    retention_days  = google_sql_database_instance.oracle_db.settings[0].backup_configuration[0].backup_retention_settings[0].retained_backups
  }
}

output "database_version" {
  description = "Versión de Oracle Database"
  value       = google_sql_database_instance.oracle_db.database_version
}

output "availability_type" {
  description = "Tipo de disponibilidad de la instancia"
  value       = google_sql_database_instance.oracle_db.settings[0].availability_type
}