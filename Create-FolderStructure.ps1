# Ask for Year Input
$year = Read-Host "Enter the Year (e.g., 2025)"

if (-not [int]::TryParse($year, [ref]0)) {
    Write-Host "Invalid Year. Exiting."
    exit
}

# Create Main Year Folder
$basePath = Join-Path -Path (Get-Location) -ChildPath $year
New-Item -ItemType Directory -Path $basePath -Force | Out-Null

# Process Each Month
for ($month = 1; $month -le 12; $month++) {
    $monthName = (Get-Culture).DateTimeFormat.GetMonthName($month)
    $monthFolder = "{0:D2}-{1}" -f $month, $monthName
    $monthPath = Join-Path -Path $basePath -ChildPath $monthFolder
    New-Item -ItemType Directory -Path $monthPath -Force | Out-Null

    # Get Last Day of the Month (Handles Leap Year Automatically)
    $lastDay = [DateTime]::DaysInMonth($year, $month)

    # Create Folders for Each Day
    for ($day = 1; $day -le $lastDay; $day++) {
        $dateObj = Get-Date -Year $year -Month $month -Day $day
        $dateFolder = "{0:dd}" -f $dateObj
        $dayPath = Join-Path -Path $monthPath -ChildPath $dateFolder
        New-Item -ItemType Directory -Path $dayPath -Force | Out-Null

        # Create Empty .txt File Named as dd-mm-yyyy.txt
        $fileName = "{0:dd-MM-yyyy}.txt" -f $dateObj
        $filePath = Join-Path -Path $dayPath -ChildPath $fileName
        New-Item -ItemType File -Path $filePath -Force | Out-Null
    }
}

Write-Host "✅ Folder structure created successfully for year $year."
