#requires -PSEdition Desktop
[CmdletBinding()]


funtion Get-OldFolder {

    Param
    (
        [Parameter(Mandatory=$true)]
        [string] $folderPath,
        [Parameter(Mandatory=$true)]
        [int] $days
    )
}
# Take files on the folder 
$filesDL = Get-ChildItem -Path $folderPath -Force

if (!(Test-Path -Path ".\logs.txt")) {
    New-Item -Path . -Name "logs.txt" -ItemType "file" -Value "Time, Time exc, file, Time in sec, Time exc in sec`n"
}

# For each file
foreach ($file in $filesDL){
    
    #Take the last exc time of the file
    $timeExc = ($file.LastAccessTime).ToFileTime()

    $limite = (Get-Date).addDays($days).ToFileTime()

    #If currently time - the last time of exec > time
    if ($timeExc - $limite -lt 0){
        #Remove file
        Remove-Item -Path "$($folderPath)\$($file)"
        Write-Host "$($file) removed"
        Add-Content -Path ".\logs.txt" -Value "$(Get-Date), $($file.LastAccessTime), $($file), $($limite), $($timeExc)"
    }
    Write-Host "-----------------"
}

