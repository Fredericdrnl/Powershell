# script 2 :
# doit regarder la date de dernière utilisation/ouverture du fichier 
# et le supprimer si la date est trop ancienne

Param
    (
        [Parameter(Mandatory=$true)]
        [string] $folderPath 
    )

Write-Host $folderPath
$date=(Get-Date).ToFileTime()
Write-Host $date
$FichiersDL = Get-ChildItem -Path $folderPath -Force
foreach ($FichiersDL in $fichierDL){
    $fichexc = $fichierDL.LastAccessTime

}

