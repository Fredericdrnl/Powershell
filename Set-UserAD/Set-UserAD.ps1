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

param (
    [Parameter(Mandatory=$true)]
    [string] $userPath
)

function Set-UserAD {
    [CmdletBinding()]

    param (
        [Parameter(Mandatory=$true)]
        [string] $userPath
    )

    begin {
        # Récupération des comptes dans le json
        try {
            $Users = Get-Content -Path "$(Get-Location)\$($PSBoundParameters['userPath'])" | ConvertFrom-Json
            Write-Verbose "Fichier json ouvert"
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
    }

    process {

        # Création du fichier de logs
        if (!(Test-Path -Path ".\logs.txt")) {
            New-Item -Path . -Name "logs.txt" -ItemType "file" -Value "------- TIME --------------- ACTION -------------`n"
        }

        # Parcour du json
        try {

            foreach ($user in $users) {
                $nameDF = "$($user.name)FD"
                $surnameDF = "$($user.surname)FD"
                $mailDF = "$($user.name).$($user.surname).FD@kenfontaineforkndeploy.onmicrosoft.com"
                $params = @{
                    accountEnabled = $true
                    displayName = "$($nameDF) $($surnameDF)"
                    mailNickname = "$($user.surname)$($user.name.Substring(0, 1))"
                    userPrincipalName = $mailDF
                    passwordProfile = @{
                        forceChangePasswordNextSignIn = $true
                        password = "xWwvJ]6NMw+bWH-d"
                    }
                }
                $compte = New-MgUser -BodyParameter $params
                Write-Verbose "Compte Cree"
                Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) cree"

                if ($user.ZDCAccount -eq $true) {
                    $mailDF = "ZDC_$($user.surname)$($user.name.Substring(0, 1))FD@kenfontaineforkndeploy.onmicrosoft.com"
                    Write-Host $mailDF
                    $paramsZDC = @{
                        accountEnabled = $true
                        displayName = "$($nameDF) $($surnameDF)"
                        mailNickname = "$($user.surname)$($user.name.Substring(0, 1))"
                        userPrincipalName = $mailDF
                        passwordProfile = @{
                            forceChangePasswordNextSignIn = $true
                            password = "xWwvJ]6NMw+bWH-d"
                        }
                    }
                    New-MgUser -BodyParameter $paramsZDC
                    Write-Verbose "Compte ZDC Cree"
                    Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte ZDC de $($nameDF) $($surnameDF) cree"
                }
                $userId = $compte.Id

                if ($user.EmployeeProfile -ilike "Profile A") {
                    #intégration dans GR USERS et APP
                    $groupeIdUsersA = "9964e550-fd83-44dd-a525-57a8452afdc2"
                    $groupeIdAppA = "c396466d-80b8-4a2b-9499-4e2139050676"
                    New-MgGroupMember -GroupId $groupeIdUsersA -DirectoryObjectId $userId
                    New-MgGroupMember -GroupId $groupeIdAppA -DirectoryObjectId $userId
                    Write-Verbose "Groupe USERS & APP A associe"
                    Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) à été ajouté dans les groupes USERS & APP A"

                    if ($user.IsExternal -eq $false) {
                        #intégration dans GR ADMIN
                        $groupeIdAdminA = "7ee94ecc-7765-4553-b0c1-25a1a6a79774"
                        New-MgGroupMember -GroupId $groupeIdAdminA -DirectoryObjectId $userId
                        Write-Verbose "Groupe ADMIN A associe"
                        Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) à été ajouté dans le groupe ADMIN A"
                    }
                    
                } 

                if ($user.EmployeeProfile -ilike "Profile B"){
                    #intégration dans GR USERS et APP
                    $groupeIdUsersB = "d12488ee-1529-40e1-b8ff-be6ca1604261"
                    $groupeIdAppB = "12d4d318-eda2-406f-99b8-a8521ba2323f"
                    New-MgGroupMember -GroupId $groupeIdUsersB -DirectoryObjectId $userId
                    New-MgGroupMember -GroupId $groupeIdAppB -DirectoryObjectId $userId
                    Write-Verbose "Groupe USERS & APP B associe"
                    Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) à été ajouté dans les groupes USERS & APP B"

                    if ($user.IsExternal -eq $false) {
                        #intégration dans GR ADMIN
                        $groupeIdAdminB = "eeea76fd-152f-404b-913e-d14a8dcbd3c7"
                        New-MgGroupMember -GroupId $groupeIdAdminB -DirectoryObjectId $userId
                        Write-Verbose "Groupe ADMIN B associe"
                        Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) à été ajouté dans le groupe ADMIN B"
                    }
                } 

                if ($user.EmployeeProfile -ilike "Profile C") {
                    #intégration dans GR USERS et APP
                    $groupeIdUsersC = "31b12bc8-53a0-455c-92da-174073e46f65"
                    $groupeIdAppC = "c20e4905-9516-4bce-8da2-9b0c437314c0"
                    New-MgGroupMember -GroupId $groupeIdUsersC -DirectoryObjectId $userId
                    New-MgGroupMember -GroupId $groupeIdAppC -DirectoryObjectId $userId
                    Write-Verbose "Groupe USERS & APP C associe"
                    Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) à été ajouté dans les groupes USERS & APP C"

                    if ($user.IsExternal -eq $false) {
                        #intégration dans GR ADMIN
                        $groupeIdAdminC = "f3dce85f-4f5f-4444-ab0f-c9a68fbdcb9b"
                        New-MgGroupMember -GroupId $groupeIdAdminC -DirectoryObjectId $userId
                        Write-Verbose "Groupe ADMIN C associe"
                        Add-Content -Path ".\logs.txt" -Value "$(Get-Date) | Compte de $($nameDF) $($surnameDF) à été ajouté dans le groupe ADMIN C"
                    }
                }
            }
        } catch {
            Write-Verbose "La création du profil n'a pas abouti"
            throw "La création du profil n'a pas abouti"
        }
    }

    end {
        #Deconexion du compte
        Disconnect-MgGraph
    }
}
Set-UserAD -userPath $userPath
