

function Set-UserAD {

    param (
        [Parameter(Mandatory=$true)]
        [string] $jsonPath,
        [Parameter(Mandatory=$true)]
        [string] $accountPath
    )

    # Récupération des comptes dans le json
    try {
        $Users = Get-Content -Path "$(Get-Location)\$($PSBoundParameters['jsonPath'])" | ConvertFrom-Json
        $Users
    } catch {
        Write-Error "Fichier json invalide"
        throw "Fichier json invalide"
    }

    # Connexion à l'AD
    try {
        $CliendId = "83efbd84-808a-4478-b30c-16df66cd410c"
        $ClientSecret = ConvertTo-SecureString -String "-~B8Q~KzTrZ7YY9iGu~Ygtx538wEFbvAQJyHHcJ9" -AsPlainText -Force
        $SecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $CliendId, $ClientSecret
        $TenantId = "2362ee81-c9fc-4f6b-a794-6e91518e5c13"
        Connect-MgGraph -CLientSecretCredential $SecretCredential -TenantId $TenantId
    } catch {
        Write-Verbose "Compte invalide"
        throw "Compte invalide"
    }
    Get-MgUser
}