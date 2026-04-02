# On session stop, if there are Tab feedback entries from this session,
# remind the user to review them.
# PowerShell version for Windows.

$FeedbackFile = Join-Path $env:USERPROFILE ".claude\tab-feedback.jsonl"

if (-not (Test-Path $FeedbackFile)) {
    exit 0
}

$Today = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd")
$Lines = Get-Content $FeedbackFile -ErrorAction SilentlyContinue
$TodayCount = ($Lines | Where-Object { $_ -match $Today }).Count
$ErrorCount = ($Lines | Where-Object { $_ -match $Today -and $_ -match '"is_error":true' }).Count

if ($TodayCount -gt 0) {
    Write-Output "{`"systemMessage`":`"Tab feedback: $TodayCount API calls logged today ($ErrorCount errors). Review with: Get-Content ~/.claude/tab-feedback.jsonl | ConvertFrom-Json`"}"
}
