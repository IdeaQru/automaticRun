pipeline {
    agent { label 'DevDevice' }

    parameters {
        booleanParam(name: 'RUN_ONBOARDING', defaultValue: true, description: 'Run onboarding step')
        booleanParam(name: 'RUN_CREATE_VOYAGE', defaultValue: true, description: 'Run create_voyage step')
    }

    triggers {
        cron('H 0 * * 1')  // Every Monday
    }

    options {
        timestamps()
        timeout(time: 2, unit: 'HOURS')
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Run') {
            steps {
                powershell -NoProfile -File "C:\\Users\\ThinkPad\\OneDrive - PT SLI\\ADA - Documents\\Operations-DEV\\bin\\jenkins_run.ps1"
            }
        }
    }

    post {
        success { echo '[SUCCESS] All tasks completed!' }
        failure { echo '[FAILED] Check logs for errors' }
    }
}
