pipeline {
    agent any

    environment {
        GCP_CREDENTIALS = credentials('gcp-sa-platform')
        // Configuración del país y proveedor
        PAIS = 'CL'
        DB_SERVICE_PROVIDER = 'GCP - Cloud SQL'
        DB_ENGINE = 'OracleSQL'
       
        // Configuración de backup y zona horaria
        DB_BACKUP_ENABLED = 'true'
        DB_TIME_ZONE = 'UTC-0'
       
        // Etiquetas y tags
        DB_RESOURCE_LABELS = 'test'
        DB_TAGS = 'test'
       
        // Credenciales de plataforma
        DB_PLATFORM_USER = 'Equipo_plataforma'
        DB_PLATFORM_PASS = 'password'
       
        // Credenciales de administrador
        DB_USER_ADMIN = 'OracleSQL'
        DB_PASSWORD_ADMIN = 'password'
    }

    parameters {
        // ========================================
        // CONFIGURACIÓN DE PROYECTO GCP
        // ========================================
        string(
            name: 'PROJECT_ID',
            defaultValue: '',
            description: 'ID del proyecto en Google Cloud Platform'
        )
        string(
            name: 'REGION',
            defaultValue: '',
            description: 'Región de GCP (ejemplo: us-central1, southamerica-west1)'
        )
        string(
            name: 'ZONE',
            defaultValue: '',
            description: 'Zona de disponibilidad (ejemplo: us-central1-a)'
        )
        choice(
            name: 'ENVIRONMENT',
            choices: ['desarrollo', 'pre productivo', 'productivo'],
            description: 'Ambiente de despliegue'
        )
       
        // ========================================
        // CONFIGURACIÓN DE BASE DE DATOS
        // ========================================
        choice(
            name: 'DB_VERSION',
            choices: ['19c', '12c', '11g'],
            description: 'Versión de Oracle Database'
        )
        string(
            name: 'DB_NAME',
            defaultValue: '',
            description: 'Nombre de la base de datos'
        )
        string(
            name: 'DB_SID',
            defaultValue: '',
            description: 'System Identifier (SID) de Oracle'
        )
        string(
            name: 'DB_CHARACTER_SET',
            defaultValue: 'AL32UTF8',
            description: 'Character Set de la base de datos (ejemplo: AL32UTF8, WE8ISO8859P1)'
        )
        string(
            name: 'DB_USERNAME',
            defaultValue: '',
            description: 'Usuario de la base de datos'
        )
        string(
            name: 'DB_PASSWORD',
            defaultValue: '',
            description: 'Contraseña del usuario de la base de datos'
        )
        string(
            name: 'DB_MAX_CONNECTIONS',
            defaultValue: '100',
            description: 'Número máximo de conexiones concurrentes'
        )
        choice(
            name: 'ENABLE_CACHE',
            choices: ['false', 'true'],
            description: 'Habilitar cache de datos en la base de datos'
        )

        // ========================================
        // CONFIGURACIÓN DE RECURSOS DE CÓMPUTO
        // ========================================
        choice(
            name: 'MACHINE_TYPE',
            choices: ['db-n2-highmem-8', 'db-n1-standard-4', 'db-custom-2-3840'],
            description: 'Tipo de máquina virtual'
        )
        
        // ========================================
        // CONFIGURACIÓN DE ALMACENAMIENTO
        // ========================================
        string(
            name: 'DB_STORAGE_SIZE',
            defaultValue: '100',
            description: 'Tamaño del almacenamiento en GB'
        )
        choice(
            name: 'DB_STORAGE_TYPE',
            choices: ['SSD', 'Balanced', 'HDD'],
            description: 'Tipo de disco de almacenamiento'
        )
        choice(
            name: 'DB_STORAGE_AUTO_RESIZE',
            choices: ['true', 'false'],
            description: 'Habilitar redimensionamiento automático del almacenamiento'
        )
        string(
            name: 'BOOT_DISK_TYPE',
            defaultValue: 'pd-ssd',
            description: 'Tipo de disco de arranque (pd-ssd, pd-standard, pd-balanced)'
        )
        string(
            name: 'BOOT_DISK_SIZE',
            defaultValue: '50',
            description: 'Tamaño del disco de arranque en GB'
        )
        string(
            name: 'OS_IMAGE',
            defaultValue: '',
            description: 'Imagen del sistema operativo'
        )

        // ========================================
        // CONFIGURACIÓN DE RED
        // ========================================
        string(
            name: 'VPC_NETWORK',
            defaultValue: 'default',
            description: 'Nombre de la red VPC'
        )
        string(
            name: 'SUBNET',
            defaultValue: '',
            description: 'Subred dentro de la VPC'
        )
        choice(
            name: 'DB_PRIVATE_IP_ENABLED',
            choices: ['true', 'false'],
            description: 'Habilitar dirección IP privada'
        )
        choice(
            name: 'DB_PUBLIC_ACCESS_ENABLED',
            choices: ['false', 'true'],
            description: 'Habilitar acceso público a la base de datos'
        )
        choice(
            name: 'DB_IP_RANGE_ALLOWED',
            choices: ['false', 'true'],
            description: 'Configurar rangos de IP permitidos'
        )

        // ========================================
        // CONFIGURACIÓN DE SEGURIDAD
        // ========================================
        choice(
            name: 'DB_SSL_ENABLED',
            choices: ['true', 'false'],
            description: 'Requerir conexiones SSL/TLS'
        )
        choice(
            name: 'DB_ENCRYPTION_ENABLED',
            choices: ['true', 'false'],
            description: 'Habilitar encriptación de datos en reposo'
        )
        choice(
            name: 'DB_DELETION_PROTECTION',
            choices: ['true', 'false'],
            description: 'Protección contra eliminación accidental'
        )
        string(
            name: 'IAM_ROLE',
            defaultValue: '',
            description: 'Rol de IAM para la instancia de base de datos'
        )
        choice(
            name: 'CREDENTIAL_FILE',
            choices: ['false', 'true'],
            description: 'Utilizar archivo de credenciales para autenticación'
        )

        // ========================================
        // CONFIGURACIÓN DE BACKUP
        // ========================================
        string(
            name: 'BACKUP_RETENTION_DAYS',
            defaultValue: '7',
            description: 'Días de retención de backups automáticos'
        )
        string(
            name: 'DB_BACKUP_START_TIME',
            defaultValue: '02:00',
            description: 'Hora de inicio de backup diario (formato HH:MM)'
        )
    }

    stages {
        stage('Validación de Parámetros') {
            steps {
                script {
                    echo '================================================'
                    echo '         VALIDACIÓN DE PARÁMETROS              '
                    echo '================================================'
                    // Validaciones básicas
                    if (!params.PROJECT_ID?.trim()) {
                        error('ERROR: PROJECT_ID es obligatorio')
                    }
                    if (!params.REGION?.trim()) {
                        error('ERROR: REGION es obligatoria')
                    }
                    if (!params.DB_NAME?.trim()) {
                        error('ERROR: DB_NAME es obligatorio')
                    }
                    echo 'Validación de parámetros completada exitosamente'
                }
            }
        }

        stage('Mostrar Configuración') {
            steps {
                script {
                    // Imprimir todas las configuraciones
                    echo '================================================'
                    echo '      CONFIGURACIÓN COMPLETA                   '
                    echo '================================================'
                    echo "ID de Proyecto: ${params.PROJECT_ID}"
                    echo "Región: ${params.REGION}"
                    echo "Zona: ${params.ZONE}"
                    echo "Ambiente: ${params.ENVIRONMENT}"
                    echo "Nombre de Base de Datos: ${params.DB_NAME}"
                    echo "Versión de Oracle: ${params.DB_VERSION}"
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    echo '================================================'
                    echo '              EJECUTANDO PLAN DE TERRAFORM      '
                    echo '================================================'
                    sh 'terraform plan -out=tfplan'  // Ejemplo de comando para Terraform Plan
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    echo '================================================'
                    echo '             EJECUTANDO APPLY DE TERRAFORM      '
                    echo '================================================'
                    sh 'terraform apply tfplan'  // Aplica el plan generado previamente
                }
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { return params.ENVIRONMENT == 'productivo' } // Solo se ejecuta en Producción
            }
            steps {
                script {
                    echo '================================================'
                    echo '             EJECUTANDO DESTROY DE TERRAFORM    '
                    echo '================================================'
                    sh 'terraform destroy -auto-approve'  // Comando para destruir la infraestructura
                }
            }
        }
    }

    post {
        success {
            echo '================================================'
            echo '           PIPELINE EJECUTADO EXITOSAMENTE      '
            echo '================================================'
        }
        failure {
            echo '================================================'
            echo '           PIPELINE FALLÓ DURANTE LA EJECUCIÓN  '
            echo '================================================'
        }
        always {
            echo '================================================'
            echo '         FIN DE LA EJECUCIÓN DEL PIPELINE       '
            echo '================================================'
        }
    }
}
