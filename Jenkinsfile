pipeline {
    agent any
    
    environment {
        // GCP_CREDENTIALS = credentials('gcp-sa-platform')
        JIRA_API_URL = 'https://bancoripley1.atlassian.net/rest/api/3/issue/'
        // GCP_CREDENTIALS =
        JIRA_USER = 'lucas.a.gomez@accenture.com'
        TOKEN_JIRA = credentials('JIRA_TOKEN')
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
            defaultValue: 'jenkins-terraform-demo-472920', 
            description: 'ID del proyecto en Google Cloud Platform'
        )
        string(
            name: 'REGION', 
            defaultValue: 'us-central1', 
            description: 'Región de GCP (ejemplo: us-central1, southamerica-west1)'
        )
        string(
            name: 'ZONE', 
            defaultValue: 'us-central1-a', 
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
            defaultValue: 'orcl', 
            description: 'Nombre de la base de datos'
        )
        string(
            name: 'DB_SID', 
            defaultValue: 'ORCL', 
            description: 'System Identifier (SID) de Oracle'
        )
        string(
            name: 'DB_CHARACTER_SET', 
            defaultValue: 'AL32UTF8', 
            description: 'Character Set de la base de datos (ejemplo: AL32UTF8, WE8ISO8859P1)'
        )
        string(
            name: 'DB_USERNAME', 
            defaultValue: 'admin', 
            description: 'Usuario de la base de datos'
        )
        string(
            name: 'DB_PASSWORD', 
            defaultValue: 'SuperSecreta123', 
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
            defaultValue: 'projects/oracle-cloud/global/images/oracle-db-19c', 
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
            defaultValue: 'default', 
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
            defaultValue: 'terraform-sa@jenkins-terraform-demo-472920.iam.gserviceaccount.com', 
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
        
        // ========================================
        // CONFIGURACIÓN DE MANTENIMIENTO
        // ========================================
        string(
            name: 'DB_MAINTENANCE_WINDOW_DAY', 
            defaultValue: 'sunday', 
            description: 'Día de la ventana de mantenimiento (ejemplo: sunday, monday)'
        )
        choice(
            name: 'DB_MAINTENANCE_WINDOW_HOUR', 
            choices: ['02:00', '03:00', '04:00'], 
            description: 'Hora de inicio de la ventana de mantenimiento'
        )
        
        // ========================================
        // CONFIGURACIÓN DE MONITOREO
        // ========================================
        choice(
            name: 'DB_MONITORING_ENABLED', 
            choices: ['true', 'false'], 
            description: 'Habilitar monitoreo avanzado con Cloud Monitoring'
        )
        
        // ========================================
        // ALTA DISPONIBILIDAD Y ESCALABILIDAD
        // ========================================
        choice(
            name: 'DB_HIGH_AVAILABILITY', 
            choices: ['false', 'true'], 
            description: 'Habilitar configuración de alta disponibilidad (HA)'
        )
        choice(
            name: 'AUTO_SCALE_ENABLED', 
            choices: ['false', 'true'], 
            description: 'Habilitar auto escalado de recursos'
        )
        string(
            name: 'DB_LISTENER_CONFIG', 
            defaultValue: '', 
            description: 'Configuración personalizada del Oracle Listener'
        )
        
        // ========================================
        // OPCIONES ADMINISTRATIVAS
        // ========================================
        choice(
            name: 'CHECK_DELETE', 
            choices: ['false', 'true'], 
            description: 'Habilitar verificación antes de eliminar recursos'
        )
        choice(
            name: 'ACTION', 
            choices: ['plan', 'apply', 'distroy'], 
            description: 'Acción a seguir'
        )
        string(
            name: 'TICKET_JIRA', 
            defaultValue: 'AJI-1', 
            description: 'Numero de ticket jira'
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
                    if(!params.ACTION?.trim()){
                        error('ERROR: ACTION es obligatorio')
                    }
                    
                    echo 'Validación de parámetros completada exitosamente'
                }
            }
        }
        
    
        stage('Capturar Configuración'){
            steps{
                script{
                     def configuracionOculta = [
                        'País': env.PAIS,
                        'Proveedor de Servicio': env.DB_SERVICE_PROVIDER,
                        'Motor de Base de Datos': env.DB_ENGINE,
                        'Backup Habilitado': env.DB_BACKUP_ENABLED,
                        'Zona Horaria': env.DB_TIME_ZONE,
                        'Etiquetas de Recursos': env.DB_RESOURCE_LABELS,
                        'Tags': env.DB_TAGS,
                        'Usuario de Plataforma': env.DB_PLATFORM_USER,
                        'Usuario Administrador': env.DB_USER_ADMIN
                    ]

                    def configuracionGCP = [
                        'Ticket Jira' : params.TICKET_JIRA,
                        'Acción a realizar' : params.ACTION,
                        'ID de Proyecto': params.PROJECT_ID,
                        'Región': params.REGION,
                        'Zona': params.ZONE,
                        'Ambiente': params.ENVIRONMENT
                    ]
                    
                    def configuracionBaseDatos = [
                        'Versión de Oracle': params.DB_VERSION,
                        'Nombre de BD': params.DB_NAME,
                        'SID': params.DB_SID,
                        'Character Set': params.DB_CHARACTER_SET,
                        'Usuario de BD': params.DB_USERNAME,
                        'Conexiones Máximas': params.DB_MAX_CONNECTIONS,
                        'Habilitar cache de datos': params.ENABLE_CACHE
                    ]
                    
                    def configuracionRecursos = [
                        'Tipo de Máquina': params.MACHINE_TYPE,
                        'Tamaño de Almacenamiento': "${params.DB_STORAGE_SIZE} GB",
                        'Tipo de Almacenamiento': params.DB_STORAGE_TYPE,
                        'Auto Resize': params.DB_STORAGE_AUTO_RESIZE,
                        'Tipo de Disco de Arranque': params.BOOT_DISK_TYPE,
                        'Tamaño de Disco de Arranque': "${params.BOOT_DISK_SIZE} GB"
                    ]
                    
                    def configuracionRed = [
                        'Red VPC': params.VPC_NETWORK,
                        'Subred': params.SUBNET,
                        'IP Privada': params.DB_PRIVATE_IP_ENABLED,
                        'Acceso Público': params.DB_PUBLIC_ACCESS_ENABLED,
                        'Rangos IP Permitidos': params.DB_IP_RANGE_ALLOWED,
                        'SSL Habilitado': params.DB_SSL_ENABLED
                    ]
                    
                    def configuracionSeguridad = [
                        'Encriptación': params.DB_ENCRYPTION_ENABLED,
                        'Protección contra Eliminación': params.DB_DELETION_PROTECTION,
                        'Rol IAM': params.IAM_ROLE,
                        'Archivo de Credenciales': params.CREDENTIAL_FILE
                    ]
                    
                    def configuracionBackup = [
                        'Días de Retención': params.BACKUP_RETENTION_DAYS,
                        'Hora de Inicio': params.DB_BACKUP_START_TIME,
                        'Día de Mantenimiento': params.DB_MAINTENANCE_WINDOW_DAY,
                        'Hora de Mantenimiento': params.DB_MAINTENANCE_WINDOW_HOUR
                    ]
                    
                    def configuracionAltaDisponibilidad = [
                        'Alta Disponibilidad': params.DB_HIGH_AVAILABILITY,
                        'Auto Escalado': params.AUTO_SCALE_ENABLED,
                        'Monitoreo Avanzado': params.DB_MONITORING_ENABLED,
                        'Configuración de Listener': params.DB_LISTENER_CONFIG
                    ]

                    
                // Guardar todo en un solo objeto JSON para reutilizar
                    env.CONFIG_JSON = groovy.json.JsonOutput.toJson([
                        configuracionOculta: configuracionOculta,
                        configuracionGCP: configuracionGCP,
                        configuracionBaseDatos: configuracionBaseDatos,
                        configuracionRecursos: configuracionRecursos,
                        configuracionRed: configuracionRed,
                        configuracionSeguridad: configuracionSeguridad,
                        configuracionBackup: configuracionBackup,
                        configuracionAltaDisponibilidad: configuracionAltaDisponibilidad,
                    ])

                }
            }
        }
        stage('Mostrar Configuración') {
            steps {
                script {
                    echo "${env.CONFIG_JSON}"
                   
                    def config = new groovy.json.JsonSlurper().parseText(env.CONFIG_JSON)
                    // Imprimir todas las configuraciones
                    echo '\n================================================'
                    echo '      CONFIGURACIÓN PREDETERMINADA (OCULTA)    '
                    echo '================================================'
                    config.configuracionOculta.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '           CONFIGURACIÓN DE GCP                '
                    echo '================================================'
                    config.configuracionGCP.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '        CONFIGURACIÓN DE BASE DE DATOS         '
                    echo '================================================'
                    config.configuracionBaseDatos.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '         CONFIGURACIÓN DE RECURSOS             '
                    echo '================================================'
                    config.configuracionRecursos.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '            CONFIGURACIÓN DE RED               '
                    echo '================================================'
                    config.configuracionRed.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '         CONFIGURACIÓN DE SEGURIDAD            '
                    echo '================================================'
                    config.configuracionSeguridad.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '        CONFIGURACIÓN DE BACKUP Y MANTENIMIENTO'
                    echo '================================================'
                    config.configuracionBackup.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '    CONFIGURACIÓN DE ALTA DISPONIBILIDAD       '
                    echo '================================================'
                    config.configuracionAltaDisponibilidad.each { k, v -> echo "  ${k}: ${v}" }
                    
                    echo '\n================================================'
                    echo '     CONFIGURACIÓN COMPLETADA                  '
                    echo '================================================\n'
                }
            }
        }
        
        


       
        // stage('Post-Jira Status') {
        //     steps {
                
        //         script {
        

                       
        //             withCredentials([usernamePassword(credentialsId: 'JIRA_TOKEN', usernameVariable: 'JIRA_USER', passwordVariable: 'JIRA_API_TOKEN')]) {
        //                 def auth = java.util.Base64.encoder.encodeToString("${JIRA_USER}:${JIRA_API_TOKEN}".getBytes("UTF-8"))
        //                 def response = sh(
        //                     script: """
        //                         curl -s -X GET '${JIRA_API_URL}${params.TICKET_JIRA}' \\
        //                         -H "Authorization: Basic ${auth}" \\
        //                         -H "Accept: application/json"
        //                     """,
        //                     returnStdout: true
        //                 ).trim()
                    
        //                 def json = new groovy.json.JsonSlurper().parseText(response)
        //                 def estado = json.fields.status.name
        //                 echo "Estado actual del ticket ${params.TICKET_JIRA}: ${estado}"
        //             }

        
        //         }
        
        //     }
        // }

        // stage('Post-Coment-jira'){
        //     steps{
        //         script{
                    
        //             withCredentials([usernamePassword(credentialsId: 'JIRA_TOKEN', usernameVariable: 'JIRA_USER', passwordVariable: 'JIRA_API_TOKEN')]) {
        //                 def auth = java.util.Base64.encoder.encodeToString("${JIRA_USER}:${JIRA_API_TOKEN}".getBytes("UTF-8"))
        //                 def comentario = "Este ticket fue comentario por Lucaneitor"

        //                 def response = sh(
        //                     script: """
        //                         curl -s -X POST "${JIRA_API_URL}${params.TICKET_JIRA}/comment" \\
        //                         -H "Authorization: Basic ${auth}" \\
        //                         -H "Content-Type: application/json" \\
        //                         -d '{
        //                             "body": {
        //                                 "type": "doc",
        //                                 "version": 1,
        //                                 "content": [
        //                                 {
        //                                     "type": "paragraph",
        //                                     "content": [
        //                                     {
        //                                         "type": "text",
        //                                         "text": "${comentario}"
        //                                     }
        //                                     ]
        //                                 }
        //                                 ]
        //                             }
        //                             }
        //                             '
        //                     """,
        //                     returnStdout: true
        //                 ).trim()

        //                 echo "Comentario enviado: ${response}"
        //             }

        //         }
        //     }
        // }

        // stage('Marcar Ticket como Finalizado en Jira') {
        //     steps {
        //         script {
        //             withCredentials([usernamePassword(credentialsId: 'JIRA_TOKEN', usernameVariable: 'JIRA_USER', passwordVariable: 'JIRA_API_TOKEN')]) {
        //                 def auth = java.util.Base64.encoder.encodeToString("${JIRA_USER}:${JIRA_API_TOKEN}".getBytes("UTF-8"))

        //                 sh """
        //                     curl -s -X POST "https://bancoripley1.atlassian.net/rest/api/3/issue/${params.TICKET_JIRA}/transitions" \
        //                     -H "Authorization: Basic ${auth}" \
        //                     -H "Content-Type: application/json" \
        //                     -d '{"transition": {"id": "31"}}'
        //                 """

        //                 echo "Ticket ${params.TICKET_JIRA} marcado como 'Finalizado'."
        //             }
        //         }
        //     }
        // }
            
        
        stage('Notify Teams') {
            steps {
                script {
                    
                    def config = new groovy.json.JsonSlurper().parseText(env.CONFIG_JSON)
                        def facts = config.collectMany { section ->
                            section.value.collect { key, value -> [name: key, value: value] }
                    }

                    def mensajeFinal = ''
                    

                    def teamsWebhookUrl = 'https://accenture.webhook.office.com/webhookb2/870e2ab9-53bf-43f6-8655-376cbe11bd1c@e0793d39-0939-496d-b129-198edd916feb/IncomingWebhook/f495e4cf395c416e83eae4fb3b9069fd/b08cc148-e951-496b-9f46-3f7e35f79570/V2r0-VttaFGsrZXpm8qS18JcqaHZ26SxRAT51CZvkTR-A1'
                    def message = """
                   
                    {
                      "@type": "MessageCard",
                      "@context": "http://schema.org/extensions",
                      "summary": "Despliegue de base de datos Oracle",
                      "themeColor": "0076D7",
                      "title": "🚀 Despliegue iniciado desde Jenkins",
                      "sections": [{
                        "activityTitle": "**Ambiente:** ${config.configuracionGCP.Ambiente}",
                        "facts": ${groovy.json.JsonOutput.toJson(facts)},
                        "markdown": true
                      }]
                    }

                    """
                    sh """
                        curl -H 'Content-Type: application/json' \
                            -d '${message}' \
                            '${teamsWebhookUrl}'
                    """
                }
            }
        }



    //     stage('Terraform Init') {
    //         steps {
    //             withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GCP_CREDENTIALS}"]) {
    //                 sh 'terraform init'
    //             }
    //         }
    //     }

    //    stage('Terraform Action') {
    //         steps {
    //             withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${GCP_CREDENTIALS}"]) {
    //                 script {
    //                     switch(params.ACTION) {
    //                         case 'plan':
    //                             echo '==== Ejecutando Terraform Plan ===='
    //                             sh """
    //                                 terraform plan -out=tfplan -var-file=terraform.tfvars
    //                             """
    //                             break
                                
    //                         case 'apply':
    //                             echo '==== Ejecutando Terraform Apply ===='
    //                             sh """
    //                                 terraform apply -auto-approve -var-file=terraform.tfvars
    //                             """
    //                             break
                                
    //                         case 'distroy':
    //                             echo '==== Ejecutando Terraform Destroy ===='
    //                             if (params.CHECK_DELETE == 'true') {
    //                                 input message: '¿Está seguro de que desea destruir la infraestructura?'
    //                             }
    //                             sh """
    //                                 terraform destroy -auto-approve -var-file=terraform.tfvars
    //                             """
    //                             break
                                
    //                         default:
    //                             error "Acción '${params.ACTION}' no reconocida"
    //                     }
    //                 }
    //             }
    //         }
    //     }

        
    }
}
