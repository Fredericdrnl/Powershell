#requires -PSEdition Desktop

<#
    .DESCRIPTION
    Script contenant une fonction permettant de se connecter à Azure directory
#>

function Connect-AD {
    $CliendId = "83efbd84-808a-4478-b30c-16df66cd410c"
    $ClientSecret = ConvertTo-SecureString -String "-~B8Q~KzTrZ7YY9iGu~Ygtx538wEFbvAQJyHHcJ9" -AsPlainText -Force
    $SecretCredential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $CliendId, $ClientSecret
    $TenantId = "2362ee81-c9fc-4f6b-a794-6e91518e5c13"
    Connect-MgGraph -CLientSecretCredential $SecretCredential -TenantId $TenantId
}

Connect-AD