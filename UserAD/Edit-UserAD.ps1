#requires -PSEdition Desktop


<#
    .DESCRIPTION
    Script contenant une fonction permettant de modifier un compte de l'AD

    .EXAMPLE
    .\Get-UserAD
#>

function Edit-UserAD {

    Param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('displayName', 'mailNickname', 'userPrincipalName', 'password')]
        [string] $what
        [Parameter(Mandatory=$true)]
        [string] $userId
        [Parameter(Mandatory=$true)]
        [string] $newValue
    )

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

    process {
        switch ($what){
            "displayName" {
                Update-MgUser -UserId $userId -DisplayName $newValue
            }
            "mailNickname" {
                Update-MgUser -UserId $userId -MailNickname $newValue
            }
            "userPrincipalName" {
                Update-MgUser -UserId $userId -UserPrincipalName $newValue
            }
            "Password" {
                params = @{
                    forceChangePasswordNextSignIn = $true
                    password = $newValue
                }
                Update-MgUser -UserId $userId -UserPrincipalName $params
            }
        }
    }

    end {
        #Deconexion du compte
        Disconnect-MgGraph
    }
}