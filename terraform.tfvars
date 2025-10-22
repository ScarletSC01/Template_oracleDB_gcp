
project_id                  = "jenkins-terraform-demo-472920"
region                      = "us-central1"
zone                        = "us-central1-a"
environment                 = "desarrollo"

db_version                  = "ORACLE_19"
db_name                     = "orcl"
db_sid                      = "ORCL"
db_character_set            = "AL32UTF8"
db_username                 = "admin"
db_password                 = "SuperSecreta123!"
db_max_connections          = 100
enable_cache                = true
machine_type                = "db-n2-highmem-8"

db_storage_size             = 200
db_storage_type             = "SSD"
db_storage_auto_resize      = true
boot_disk_type              = "pd-ssd"
boot_disk_size              = 50
os_image                    = "projects/oracle-cloud/global/images/oracle-db-19c"

vpc_network                 = "default"
subnet                      = "default"
db_private_ip_enabled       = true
db_public_access_enabled    = false
db_ip_range_allowed         = false

db_ssl_enabled              = true
db_encryption_enabled       = true
db_deletion_protection      = true
iam_role                    = "mi-servicio@mi-proyecto.iam.gserviceaccount.com"
credential_file             = true

backup_retention_days       = 7
db_backup_start_time        = "02:00"

db_maintenance_window_day   = "sunday"
db_maintenance_window_hour  = "03:00"

db_monitoring_enabled       = true

db_high_availability        = false
auto_scale_enabled          = false
db_listener_config          = ""

check_delete                = true

