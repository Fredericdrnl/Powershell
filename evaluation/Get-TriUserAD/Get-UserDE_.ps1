#requires -PSEdition Desktop

<#
    .DESCRIPTION
    Script permettant de retourner les comptes AD commençant par "DE_"

    .EXAMPLE
    sans affichage .\Get-TriUserAD.ps1
    avec affichage .\Get-TriUserAD.ps1 -Verbose
#>

function Get-UserDE_ {

    begin {

        # Connexion à l'AD
        try {
            $CliendId = "7f9dd165-cf16-495d-9a4b-2d4908e55b47"
            $ClientSecret = ConvertTo-SecureString -String "uvK8Q~C8NKUF54dwrkG8Fbr7kLVBUfiKg~UC8bOY" -AsPlainText -Force
            $SecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $CliendId, $ClientSecret
            $TenantId = "0197b94a-021f-4794-8c1e-0a4ac9b304a4"
            Connect-MgGraph -CLientSecretCredential $SecretCredential -TenantId $TenantId
        } catch {
            Write-Verbose "Compte invalide"
            throw "Compte invalide"
        }
    }

    process {

        # Get users on Azure AD
        try {
            Get-MgUser -All -ConsistencyLevel: eventual -Filter "startswith(DisplayName, 'DE_')" | ForEach-Object {
                [pscustomobject]@{
                    DisplayName = $_.DisplayName
                    UserPrincipaleName = $_.UserPrincipalName
                    Id = $_.Id
                }
             } | Export-Csv -path "DE.csv" -NoTypeInformation
        }
        catch {
            throw "la Récupération des utilisateurs n'a pas abouti"
            Write-Error "la Récupération des utilisateurs n'a pas abouti"
        }
    }

    end {
        Disconnect-MgGraph
    }

}

Get-UserDE_