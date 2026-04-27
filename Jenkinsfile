pipeline {
    agent { label 'DevDevice' }

    triggers {
        cron('H 0 * * 1')  // Every Monday
    }

    environment {
        SCRIPT = 'C:\\Users\\ThinkPad\\OneDrive - PT SLI\\ADA - Documents\\Operations-DEV\\bin\\jenkins_build.ps1'
    }

    options {
        timestamps()
        timeout(time: 2, unit: 'HOURS')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Run') {
            steps {
                echo "==========================================="
                echo "ADA System Automated Tasks"
                echo "==========================================="
                powershell "& '${env.SCRIPT}'"
            }
        }
    }

    post {
        success { echo '[SUCCESS] All tasks completed!' }
        failure { echo '[FAILED] Check logs for errors' }
    }
}
