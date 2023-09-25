Param
    (
        [Parameter(Mandatory=$true)]
        [string[]] $codePostales
    )

$index = 0
if (!(Test-Path -Path ".\data.txt")) {
    New-Item -Path . -Name "data.txt" -ItemType "file" -Value "Nom, Population, Code Postale`n"
}
while (!($codePostales[$index] -like $null) -and ($index -lt $codePostales.Count)) {
    $departementCode = $codePostales[$index].Substring(0,2) 
    $urlCommunes = "https://geo.api.gouv.fr/departements/$($departementCode)/communes"
    $listCommunes = Invoke-RestMethod -Uri $urlCommunes -Method 'Get'
    foreach( $commune in $listCommunes ){
        if ( $codePostales[$index] -eq $commune.code ){
            $nomCommune = $commune.nom
            $populationCommune = $commune.population
            $codePostaleCommune = $commune.code 
            Write-Host "Nom : $($nomCommune), Population : $($populationCommune), Code Postale : $($codePostaleCommune)"
            Add-Content -Path ".\data.txt" -Value "$($nomCommune), $($populationCommune), $($codePostaleCommune)"
        }
    }
    $index ++
}
$file = ".\data.txt"
Import-Csv $file | export-csv "data.csv" -NoTypeInformation

