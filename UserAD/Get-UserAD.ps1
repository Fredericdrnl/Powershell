#requires -PSEdition Desktop


<#
    .DESCRIPTION
    Script contenant une fonction permettant de Récupérer les utilisateurs de l'AD

    .OUTPUTS
    Tous les utilisateurs de l'AD

    .EXAMPLE
    .\Get-UserAD
#>

function Get-UserAD {

    begin {
        # Connexion à l'AD
        try {
            # Connect-AD
            . ".\Connect-AD.ps1"
        } catch {
            Write-Verbose "Compte invalide"
            throw "Compte invalide"
        }
    }
    
    end {
        return Get-MgUser
    }
}

Get-UserAD