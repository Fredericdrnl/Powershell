

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
    try {
        Connect-MgGraph -Scopes "User.Read.All","Group.ReadWrite.All"
    } catch {
        Write-Verbose "Compte invalide"
        throw "Compte invalide"
    }
}
# Set-UserAD -jsonPath $PSBoundParameters['jsonPath']  -accountPath $PSBoundParameters['accountPath']
Set-UserAD -jsonPath ".\user.json"  -accountPath ".\account.json"