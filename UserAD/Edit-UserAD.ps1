#requires -PSEdition Desktop

<#
    .DESCRIPTION
    Script contenant une fonction permettant de modifier un compte de l'AD

    .EXAMPLE
    .\Edit-UserAD -what displayName -userId  "08967d7d-1ec3-4345-9074-c96fb90f8b20" -newValue  "Benjanul Fournier"
#>

Param (
    [Parameter(Mandatory=$true)]
    [ValidateSet('displayName', 'mailNickname', 'userPrincipalName', 'password')]
    [string] $what
    [Parameter(Mandatory=$true)]
    [string] $userId
    [Parameter(Mandatory=$true)]
    [string] $newValue
)


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

Edit-UserAD -what $what -userId $userId -newValue $newValue