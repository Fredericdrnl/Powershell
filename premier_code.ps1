Param
    (
        [Parameter(Mondatory=$true)]
        [String]
        $folderPath 
        # c'est un paramettre à mettre lors de l'execution
    )


$MesFichiers = get-ChildItem -Path "c:\Users\frede\Desktop" -Force

Write-Host "Toto  $($MesFichiers[0].Name)"
Write-Warning "Toto $($MesFichiers[0].Name)" 
Write-Error "Error"
$MesFichiers[0].Name

$MesFichiers = get-ChildItem -Path "c:\Users\frede\Desktop" -Force | Write-Host $_[0].Name

if($MesFichiers[0].length -gt 100){
    Write-Host "Mon fichier est plus grand que 100"
} else {
    Write-Host "Mon fichier est plus petit que 100"
}

$MesFichiers[0].length -gt 100 ? "Mon fichier est plus grand que 100" : "Mon fichier est plus petit que 100"


foreach($MonFichier in $MesFichiers){
    Write-Host "$($MonFichier.Name)"
}


