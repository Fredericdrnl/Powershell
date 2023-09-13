# script 1 :
# doit comparer les extensions des fichiers 
# dans téléchargement et les ranger dans un dossier (le créer dynamiquement si besoin)

Param
    (
        [Parameter(Mandatory=$true)]
        [string] $folderPath 
    )
    
Write-Host $folderPath
$FichiersDL = Get-ChildItem -Path $folderPath -Force
foreach ($FichierDL in $FichiersDL){
    $extension =[System.IO.Path]::GetExtension($FichierDL)
    if (!($extension -like $FichierDL)){
        if (!($extension -like "")){
            Write-Host "$($extension)"
            Write-Host "$($folderPath)$extension"
            if (!(Test-Path "$($folderPath)$($extension)")){
                New-Item "$($folderPath)$extension" -itemType Directory
            }
            Copy-Item "$($folderPath)$($FichierDL)" -Destination "$($folderPath)$extension" 
            Remove-Item -Path "$($folderPath)$($FichierDL)"
        }
    }
}

