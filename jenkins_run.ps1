$argList = @()
if (-not $env:RUN_ONBOARDING) { $argList += "-SkipOnboarding" }
if (-not $env:RUN_CREATE_VOYAGE) { $argList += "-SkipCreateVoyage" }
& "C:/Users/ThinkPad/OneDrive - PT SLI/ADA - Documents/Operations-DEV/bin/jenkins_build.ps1" $argList 2>&1 | Out-Default
