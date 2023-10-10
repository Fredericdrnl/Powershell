#requires -PSEdition Desktop

<#
    .DESCRIPTION
    Script contenant une fonction permettant de Créer des comptes Azure AD à partir d'un fichier json.
    
    .PARAMETER userPath
    Le chemin d'acces du fichier json avec les comptes.

    .EXAMPLE
    Sans affichage .\Set-UserAD.ps1 -userPath user.json
    Avec affichage .\Set-UserAD.ps1 -userPath user.json -Verbose
#>

function Delete_UserAD {

    param (
    [Parameter(Mandatory=$true)]
    [string[]] $accounts
    )
}