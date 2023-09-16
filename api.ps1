Param
    (
        [Parameter(Mandatory=$true)]
        [string] $codePostale
    )
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
