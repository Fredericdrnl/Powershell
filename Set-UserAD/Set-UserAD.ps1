

function Set-UserAD {

    param (
        [Parameter(Mandatory=$true)]
        [string] $jsonPath,
        [Parameter(Mandatory=$true)]
        [string] $accountPath
    )

    $Users = Get-Content -Path $($PSBoundParameters['jsonPath']) | ConvertFrom-Json
    $Users
    # Récupération des comptes dans le json
    # try {
    #     $Users = Get-Content -Path $($PSBoundParameters['jsonPath']) | ConvertFrom-Json
    #     Write-Verbose $Users
    # } catch {
    #     Write-Error "Fichier json invalide"
    #     throw "Fichier json invalide"
    # }

    # Connexion à l'AD
    # try {
    #     Connect-MgGraph -TenantId "2362ee81-c9fc-4f6b-a794-6e91518e5c13" -ClientId "83efbd84-808a-4478-b30c-16df66cd410c" -ClientSecret "-~B8Q~KzTrZ7YY9iGu~Ygtx538wEFbvAQJyHHcJ9"
    #     Get-MgUser
    # } catch {
    #     Write-Verbose "Compte invalide"
    #     throw "Compte invalide"
    # }
    Connect-MgGraph -TenantId "2362ee81-c9fc-4f6b-a794-6e91518e5c13" -ClientId "83efbd84-808a-4478-b30c-16df66cd410c"
    Get-MgUser
}
# Set-UserAD -jsonPath $PSBoundParameters['jsonPath']  -accountPath $PSBoundParameters['accountPath']
Set-UserAD -jsonPath ".\user.json"  -accountPath ".\account.json"