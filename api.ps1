Param
    (
        [Parameter(Mandatory=$true)]
        [string] $codePostale
    )
    (
        [string] $codePostale2
    )
    (
        [string] $codePostale3
    )
    (
        [string] $codePostale4
    )
    (
        [string] $codePostale5
    )
    (
        [string] $codePostale6
    )
$code = $codePostale, $codePostale2, $codePostale3, $codePostale4, $codePostale5, $codePostale6
$index = 0
while (!($code[0] -ilike $null) -and ($index -lt $code.Count - 1)) {
    Write-Host $index
    Write-Host $code.Count
    $departementCode = $codePostale.Substring(0,2) 
    $urlCommunes = "https://geo.api.gouv.fr/departements/$($departementCode)/communes"
    $listCommunes = Invoke-RestMethod -Uri $urlCommunes -Method 'Get'
    foreach( $commune in $listCommunes ){
        if ( $codePostale -eq $commune.code ){
            $nomCommune = $commune.nom
            $populationCommune = $commune.population
            $codePostaleCommune = $commune.code 
            Write-Host "Nom : $($nomCommune), Population : $($populationCommune), Code Postale : $($codePostaleCommune)"
        }
    }
    $index ++
}

