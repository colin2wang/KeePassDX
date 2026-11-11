<#
.SYNOPSIS
    Build script for KeePassDX (Android Gradle project).

.DESCRIPTION
    Wraps the Gradle wrapper (gradlew.bat) with common build tasks.
    All output and comments are in English.

.EXAMPLE
    .\build.ps1                # Run debug build
    .\build.ps1 -Task assembleRelease
    .\build.ps1 -Help
#>

param(
    # Gradle task to execute (default: assembleDebug)
    [string]$Task = "assembleDebug",

    # Extra arguments passed through to Gradle
    [string[]]$GradleArgs = @(),

    # Show help text
    [switch]$Help
)

# Show usage information
function Show-Help {
    Write-Host "Usage: .\build.ps1 [-Task <task>] [-GradleArgs <args...>] [-Help]" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Parameters:"
    Write-Host "  -Task        Gradle task to run. Default: assembleDebug"
    Write-Host "  -GradleArgs  Extra arguments forwarded to gradlew.bat"
    Write-Host "  -Help        Show this help text and exit"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\build.ps1                          # Debug build"
    Write-Host "  .\build.ps1 -Task assembleRelease    # Release build"
    Write-Host "  .\build.ps1 -Task clean assembleDebug"
    Write-Host "  .\build.ps1 -Task test -GradleArgs '--info'"
}

# Handle -Help
if ($Help) {
    Show-Help
    exit 0
}

# Locate gradlew.bat in the script directory
$gradlew = Join-Path $PSScriptRoot "gradlew.bat"
if (-not (Test-Path $gradlew)) {
    Write-Error "gradlew.bat not found in $PSScriptRoot. Are you running this from the project root?"
    exit 1
}

Write-Host "Running Gradle task(s): $Task $($GradleArgs -join ' ')" -ForegroundColor Green

# Execute the Gradle build
& $gradlew $Task @GradleArgs
$exitCode = $LASTEXITCODE

if ($exitCode -ne 0) {
    Write-Error "Gradle build failed with exit code $exitCode"
} else {
    Write-Host "Build finished successfully." -ForegroundColor Green
}

exit $exitCode
