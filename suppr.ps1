# script 2 :
# doit regarder la date de dernière utilisation/ouverture du fichier 
# et le supprimer si la date est trop ancienne

Param
    (
        [Parameter(Mandatory=$true)]
        [string] $folderPath,
        [Parameter(Mandatory=$true)]
        [int] $days
    )

Write-Host $folderPath

# Currently time of program exec
# $currently=(Get-Date).ToFileTime()
# Write-Host $currently

# Take files on the folder 
$filesDL = Get-ChildItem -Path $folderPath -Force

if (!(Test-Path -Path ".\logs.txt")) {
    New-Item -Path . -Name "logs.txt" -ItemType "file" -Value "Time, Time exc, file`n"
}

# For each file
foreach ($file in $filesDL){
    Write-Host $filesDL

    #Take the last exc time of the file
    $timeExc = ($file.LastAccessTime).ToFileTime()
    Write-Host $timeExc

    $limite = (Get-Date).addDays($days).ToFileTime()
    Write-Host $limite

    #If currently time - the last time of exec > time
    if ($timeExc - $limite -lt 0){
        #Remove file
        # Remove-Item -Path "$($folderPath)\$($file)"
        Write-Host "$($file) removed"
        Add-Content -Path ".\logs.txt" -Value "$(Get-Date), $($timeExc), $($file)"
    }
    Write-Host "-----------------"
}

