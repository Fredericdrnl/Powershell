Param
    (
        [Parameter(Mandatory=$true)]
        [string] $codePostale,
        [string] $codePostale2,
        [string] $codePostale3,
        [string] $codePostale4,
        [string] $codePostale5,
        [string] $codePostale6
    )
$code = $codePostale, $codePostale2, $codePostale3, $codePostale4, $codePostale5, $codePostale6
$index = 0
if (!(Test-Path -Path ".\data.txt")) {
    New-Item -Path . -Name "data.txt" -ItemType "file" -Value "Nom, Population, Code Postale`n"
}
while (!($code[$index] -like $null) -and ($index -lt $code.Count)) {
    $departementCode = $code[$index].Substring(0,2) 
    $urlCommunes = "https://geo.api.gouv.fr/departements/$($departementCode)/communes"
    $listCommunes = Invoke-RestMethod -Uri $urlCommunes -Method 'Get'
    foreach( $commune in $listCommunes ){
        if ( $code[$index] -eq $commune.code ){
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

