#requires -PSEdition Desktop

<#
    .DESCRIPTION
    Script contenant une fonction permettant de supprimer des comptes Azure AD.
    
    .PARAMETER accounts
    Liste de prénom suivi du nom de l'utilisateur à supprimer

    .EXAMPLE
    Sans affichage .\Delete-UserAD.ps1 -accounts "AvaFD JacksonFD"
    Avec affichage .\Delete-UserAD.ps1 -accounts "AvaFD JacksonFD", "MiaFD WilsonFD" -Verbose
    Avec affichage .\Delete-UserAD.ps1 -accounts "AvaFD JacksonFD" -Verbose
#>

Param (
    [Parameter(Mandatory=$true)]
    [string[]] $accounts
)

function Remove-UserAD {
    [CmdletBinding()]
    
    Param (
        [Parameter(Mandatory=$true)]
        [string[]] $accounts
    )

    begin {
        # Connexion à l'AD
        try {
            . ".\Connect-AD.ps1"
        } catch {
            Write-Verbose "Compte invalide"
            throw "Compte invalide"
        }
    }

    process {
        foreach($account in $accounts) {
            $users = Get-MgUser -ConsistencyLevel eventual -Count userCount -Search "DisplayName: $($account)"
            if (!($null -eq $users)){
                foreach($user in $users){
                    Write-Verbose $user.displayName
                    Remove-MgUser -UserId $user.Id 
                    Write-Verbose "Compte supprime"
                }
            }
        }
    }

    end {
        #Deconexion du compte
        Disconnect-MgGraph
    }
}

Delete-UserAD -accounts $accounts