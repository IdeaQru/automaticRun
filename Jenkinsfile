pipeline {
     agent { label 'DevDevice' }

    parameters {
        booleanParam(name: 'RUN_ONBOARDING', defaultValue: true, description: 'Run onboarding step')
        booleanParam(name: 'RUN_CREATE_VOYAGE', defaultValue: true, description: 'Run create_voyage step')
    }

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
                    $argList = @()
                    if (-not $env:RUN_ONBOARDING) { $argList += '-SkipOnboarding' }
                    if (-not $env:RUN_CREATE_VOYAGE) { $argList += '-SkipCreateVoyage' }
                    & "C:\\Users\\ThinkPad\\OneDrive - PT SLI\\ADA - Documents\\Operations-DEV\\bin\\jenkins_build.ps1" $argList
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