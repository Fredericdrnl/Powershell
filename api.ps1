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
while (!($code[$index] -like $null) -and ($index -lt $code.Count)) {
    Write-Host $code[$index]
    $departementCode = $code[$index].Substring(0,2) 
    $urlCommunes = "https://geo.api.gouv.fr/departements/$($departementCode)/communes"
    $listCommunes = Invoke-RestMethod -Uri $urlCommunes -Method 'Get'
    foreach( $commune in $listCommunes ){
        if ( $codePostale -eq $commune.code ){
            Write-Host $codePostale
            $nomCommune = $commune.nom
            $populationCommune = $commune.population
            $codePostaleCommune = $commune.code 
            Write-Host "Nom : $($nomCommune), Population : $($populationCommune), Code Postale : $($codePostaleCommune)"
        }
    }
    $index ++
}

