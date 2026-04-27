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
                echo "==========================================="
                echo "ADA System Automated Tasks"
                echo "==========================================="
                powershell -NoProfile '''
                    $argList = @()
                    if (-not \$env:RUN_ONBOARDING) { $argList += "-SkipOnboarding" }
                    if (-not \$env:RUN_CREATE_VOYAGE) { $argList += "-SkipCreateVoyage" }
                    & "C:\\Users\\ThinkPad\\OneDrive - PT SLI\\ADA - Documents\\Operations-DEV\\bin\\jenkins_build.ps1" $argList 2>&1 | Out-Default
                '''
            }
        }
    }

    post {
        success { echo '[SUCCESS] All tasks completed!' }
        failure { echo '[FAILED] Check logs for errors' }
    }
}
