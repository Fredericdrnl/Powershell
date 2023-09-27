param ([string[]] $codesPostaux)

# Parcourir la liste des codes postaux
foreach ($codePostal in $codesPostaux) {
    $apiUrl = "https://geo.api.gouv.fr/communes?codePostal=$codePostal"
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get

    if ($response.Count -eq 0) {Write-Host "Aucune information trouvée pour $codePostal."}
    else {
        foreach ($ville in $response) {
            $nom = $ville.nom
            $population = $ville.population

            # Afficher les informations
            Write-Host "Code Postal : $codePostal"
            Write-Host "Nom : $nom"
            Write-Host "Population : $population"
            
            # Écrire dans un fichier CSV
            $csvData = [PSCustomObject]@{
                "Code Postal" = $codePostal
                "Nom" = $nom
                "Population" = $population
            }
            $csvData | Export-Csv -Append -Path "resultats.csv" -NoTypeInformation
        }
    }
}