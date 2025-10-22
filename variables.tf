// ========================================
// CONFIGURACIÓN DE PROYECTO GCP
// ========================================
variable "project_id" {
  description = "ID del proyecto en Google Cloud Platform"
  type        = string
}

variable "region" {
  description = "Región de GCP (ejemplo: us-central1, southamerica-west1)"
  type        = string
}

variable "zone" {
  description = "Zona de disponibilidad (ejemplo: us-central1-a)"
  type        = string
}

variable "environment" {
  description = "Ambiente de despliegue"
  type        = string
  validation {
    condition     = contains(["desarrollo", "pre productivo", "productivo"], var.environment)
    error_message = "El valor debe ser 'desarrollo', 'pre productivo' o 'productivo'."
  }
}

// ========================================
// CONFIGURACIÓN DE BASE DE DATOS
// ========================================
variable "db_version" {
  description = "Versión de Oracle Database"
  type        = string
  validation {
    condition     = contains(["19c", "12c", "11g"], var.db_version)
    error_message = "Versión no válida. Usa '19c', '12c' o '11g'."
  }
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "db_sid" {
  description = "System Identifier (SID) de Oracle"
  type        = string
}

variable "db_character_set" {
  description = "Character Set de la base de datos"
  type        = string
  default     = "AL32UTF8"
}

variable "db_username" {
  description = "Usuario de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_max_connections" {
  description = "Número máximo de conexiones concurrentes"
  type        = number
  default     = 100
}

variable "enable_cache" {
  description = "Habilitar cache de datos en la base de datos"
  type        = bool
}

// ========================================
// CONFIGURACIÓN DE RECURSOS DE CÓMPUTO
// ========================================
variable "machine_type" {
  description = "Tipo de máquina virtual"
  type        = string
  validation {
    condition     = contains(["db-n2-highmem-8", "db-n1-standard-4", "db-custom-2-3840"], var.machine_type)
    error_message = "Tipo de máquina no válido."
  }
}

// ========================================
// CONFIGURACIÓN DE ALMACENAMIENTO
// ========================================
variable "db_storage_size" {
  description = "Tamaño del almacenamiento en GB"
  type        = number
  default     = 100
}

variable "db_storage_type" {
  description = "Tipo de disco de almacenamiento"
  type        = string
  validation {
    condition     = contains(["SSD", "Balanced", "HDD"], var.db_storage_type)
    error_message = "Tipo de almacenamiento no válido."
  }
}

variable "db_storage_auto_resize" {
  description = "Habilitar redimensionamiento automático del almacenamiento"
  type        = bool
}

variable "boot_disk_type" {
  description = "Tipo de disco de arranque"
  type        = string
  default     = "pd-ssd"
}

variable "boot_disk_size" {
  description = "Tamaño del disco de arranque en GB"
  type        = number
  default     = 50
}

variable "os_image" {
  description = "Imagen del sistema operativo"
  type        = string
}

// ========================================
// CONFIGURACIÓN DE RED
// ========================================
variable "vpc_network" {
  description = "Nombre de la red VPC"
  type        = string
  default     = "default"
}

variable "subnet" {
  description = "Subred dentro de la VPC"
  type        = string
}

variable "db_private_ip_enabled" {
  description = "Habilitar dirección IP privada"
  type        = bool
}

variable "db_public_access_enabled" {
  description = "Habilitar acceso público a la base de datos"
  type        = bool
}

variable "db_ip_range_allowed" {
  description = "Configurar rangos de IP permitidos"
  type        = bool
}

// ========================================
// CONFIGURACIÓN DE SEGURIDAD
// ========================================
variable "db_ssl_enabled" {
  description = "Requerir conexiones SSL/TLS"
  type        = bool
}

variable "db_encryption_enabled" {
  description = "Habilitar encriptación de datos en reposo"
  type        = bool
}

variable "db_deletion_protection" {
  description = "Protección contra eliminación accidental"
  type        = bool
}

variable "iam_role" {
  description = "Rol de IAM para la instancia de base de datos"
  type        = string
}

variable "credential_file" {
  description = "Utilizar archivo de credenciales para autenticación"
  type        = bool
}

// ========================================
// CONFIGURACIÓN DE BACKUP
// ========================================
variable "backup_retention_days" {
  description = "Días de retención de backups automáticos"
  type        = number
  default     = 7
}

variable "db_backup_start_time" {
  description = "Hora de inicio de backup diario (formato HH:MM)"
  type        = string
  default     = "02:00"
}

// ========================================
// CONFIGURACIÓN DE MANTENIMIENTO
// ========================================
variable "db_maintenance_window_day" {
  description = "Día de la ventana de mantenimiento"
  type        = string
  default     = "sunday"
}

variable "db_maintenance_window_hour" {
  description = "Hora de inicio de la ventana de mantenimiento"
  type        = string
  validation {
    condition     = contains(["02:00", "03:00", "04:00"], var.db_maintenance_window_hour)
    error_message = "Hora no válida. Usa '02:00', '03:00' o '04:00'."
  }
}

// ========================================
// CONFIGURACIÓN DE MONITOREO
// ========================================
variable "db_monitoring_enabled" {
  description = "Habilitar monitoreo avanzado con Cloud Monitoring"
  type        = bool
}

// ========================================
// ALTA DISPONIBILIDAD Y ESCALABILIDAD
// ========================================
variable "db_high_availability" {
  description = "Habilitar configuración de alta disponibilidad (HA)"
  type        = bool
}

variable "auto_scale_enabled" {
  description = "Habilitar auto escalado de recursos"
  type        = bool
}

variable "db_listener_config" {
  description = "Configuración personalizada del Oracle Listener"
  type        = string
}

// ========================================
// OPCIONES ADMINISTRATIVAS
// ========================================
variable "check_delete" {
  description = "Habilitar verificación antes de eliminar recursos"
  type        = bool
}