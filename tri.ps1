# script 1 :
# doit comparer les extensions des fichiers 
# dans téléchargement et les ranger dans un dossier (le créer dynamiquement si besoin)

Param
    (
        [Parameter(Mandatory=$true)]
        [string] $folderPath 
    )
    
Write-Host $folderPath
$filesDL = Get-ChildItem -Path $folderPath -Force
foreach ($file in $filesDL){
    $extension =[System.IO.Path]::GetExtension($file)
    if (!($extension -like $file)){
        if (!($extension -like "")){
            Write-Host "$($extension)"
            Write-Host "$($folderPath)$extension"
            if (!(Test-Path "$($folderPath)$($extension)")){
                New-Item "$($folderPath)$extension" -itemType Directory
            }
            Copy-Item "$($folderPath)$($file)" -Destination "$($folderPath)$extension" 
            Remove-Item -Path "$($folderPath)$($file)"
        }
    }
}

