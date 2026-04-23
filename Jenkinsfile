pipeline {
    agent any

    triggers {
        cron('10 0 * * 1')
    }

    options {
        timestamps()
        timeout(time: 1, unit: 'HOURS')
    }

    stages {
        stage('Run Automated Tasks') {
            steps {
                powershell '''
                    D:\\automaticRun\\jenkins_build.ps1
                '''
            }
        }
    }

    post {
        success {
            echo 'Automated tasks completed successfully'
        }
        failure {
            echo 'Automated tasks failed'
        }
    }
}
