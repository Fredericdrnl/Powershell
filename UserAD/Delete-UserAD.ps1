#requires -PSEdition Desktop

<#
    .DESCRIPTION
    Script contenant une fonction permettant de supprimer des comptes Azure AD à partir d'un fichier json.
    
    .PARAMETER accounts
    Le prénom suivi du nom de l'utilisateur à supprimer

    .EXAMPLE
    Sans affichage .\Delete-UserAD.ps1 -accounts "AvaFD JacksonFD"
    Avec affichage .\Delete-UserAD.ps1 -accounts "AvaFD JacksonFD", "MiaFD WilsonFD" -Verbose
    Avec affichage .\Delete-UserAD.ps1 -accounts "AvaFD JacksonFD" -Verbose
#>

Param (
    [Parameter(Mandatory=$true)]
    [string[]] $accounts
)

function Delete-UserAD {

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
            if (!($users -eq $null)){
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