pipeline {
    agent DevDevice

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
                    \$params = @{}
                    if (-not \$env:RUN_ONBOARDING) { \$params['skip_onboarding'] = \$true }
                    if (-not \$env:RUN_CREATE_VOYAGE) { \$params['skip_create_voyage'] = \$true }

                    & "D:\\AdaSystem\\automaticRun\\jenkins_build.ps1" @\$params
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