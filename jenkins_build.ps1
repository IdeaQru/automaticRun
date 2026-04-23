# Jenkins build script for ADA System Automated Tasks
# Runs every Monday at 00:10
# Executes: onboarding, generate_report, create_voyage with dynamic date range

param(
    [string]$WorkingDirectory = "D:\AdaSystem\ada-report_v2\dist\bin"
)

# Change to working directory
Set-Location -Path $WorkingDirectory

Write-Host "=============================================="
Write-Host "ADA System Automated Tasks - Starting"
Write-Host "Execution Time: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host "=============================================="

# Calculate dynamic date range (previous week: Monday to Sunday)
# Assumes script runs on Monday, so we need previous week's data
$today = Get-Date

# Find the most recent Monday (start of previous week)
# If today is Monday, we go back 7 days to get previous Monday
$dayOfWeek = $today.DayOfWeek.value__
$daysSinceMonday = if ($dayOfWeek -eq [DayOfWeek]::Monday) { 7 } else { (0..6 | Where-Object { $today.AddDays(-$_).DayOfWeek -eq [DayOfWeek]::Monday } | Select-Object -First 1) }

# Calculate previous week's Monday
$startDate = $today.AddDays(-$daysSinceMonday).Date.AddDays(-(6 - $daysSinceMonday + $daysSinceMonday))
$startDate = $today.AddDays(-$daysSinceMonday - 6).Date

# Calculate previous week's Sunday
$endDate = $startDate.AddDays(6)

Write-Host ""
Write-Host "Date Range: $($startDate.ToString('yyyy-MM-dd')) to $($endDate.ToString('yyyy-MM-dd'))"
Write-Host ""

# Step 1: Onboarding
Write-Host "[1/3] Running onboarding..."
& "$WorkingDirectory\onboarding" onboard --all
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Onboarding failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "Onboarding completed successfully" -ForegroundColor Green

# Step 2: Generate Report
Write-Host ""
Write-Host "[2/3] Running create_voyage..."

& "$WorkingDirectory\create_voyage" --start $startDate.ToString('yyyy-MM-dd') --end $endDate.ToString('yyyy-MM-dd')
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Create voyage failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
& "$WorkingDirectory\generate_report" --start $startDate.ToString('yyyy-MM-dd') --end $endDate.ToString('yyyy-MM-dd')
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Generate report failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "Generate report completed successfully" -ForegroundColor Green

# Step 3: Create Voyage
Write-Host ""
Write-Host "[3/3] Running generate_report..."
& "$WorkingDirectory\generate_report" --start $startDate.ToString('yyyy-MM-dd') --end $endDate.ToString('yyyy-MM-dd')
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Generate report failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}
Write-Host "Create voyage completed successfully" -ForegroundColor Green

Write-Host ""
Write-Host "=============================================="
Write-Host "ADA System Automated Tasks - Completed"
Write-Host "=============================================="

exit 0
