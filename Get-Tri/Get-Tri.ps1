#requires -PSEdition Desktop
[CmdletBinding()]

<#
    .DESCRIPTION
    Script contenant une fonction permettant de trier un dossier donné en paramètre.
    
    .PARAMETER folderPath
    Le chemin d'acces du fichier à trier.

    .OUTPUTS
    La fonction retourne le fichier trié

    .EXAMPLE
    sans affichage .\Get-Tri.ps1 -folderPath .\test
    avec affichage .\Get-Tri.ps1 -folderPath .\test -Verbose
#>

param (
    [Parameter(Mandatory=$true)]
    [string] $folderPath 
)

function Get-tri {

    param (
        [Parameter(Mandatory=$true)]
        [string] $folderPath 
    )
    
    begin {
        Write-Verbose $PSBoundParameters['folderPath']
        try {
            # Take files on the folder 
            $filesDirectory = Get-ChildItem -Path $PSBoundParameters['folderPath'] -Force
        } catch {
            Write-Error "Le chemin spécifié en paramètre est invalide"
            throw "Le chemin spécifié en paramètre est invalide"
        }
    }
    process {
        # For each file
        foreach ($file in $filesDirectory){

            # Get extension of the file
            $extension =[System.IO.Path]::GetExtension($file)
                
            # If the file isn't a folder
            if (!($extension -like "")){
                Write-Verbose "$($extension)"
                Write-Verbose "$($PSBoundParameters['folderPath'])\$extension"
                
                #IF the folder exist
                if (!(Test-Path "$($PSBoundParameters['folderPath'])\$($extension)")){
                    New-Item "$($PSBoundParameters['folderPath'])\$extension" -itemType Directory
                }
                
                try{
                    # Copy and paste file
                    Copy-Item "$($PSBoundParameters['folderPath'])\$($file)" -Destination "$($PSBoundParameters['folderPath'])\$extension" 
                    Remove-Item -Path "$($PSBoundParameters['folderPath'])\$($file)"
                } catch {
                    Write-Error "Le fichier n'a pas pu être déplacé"
                    throw "Le fichier n'a pas pu être déplacé"
                }
            }
        }
    }

    end {
        return $filesDirectory
    }

}
$filesDirectory = Get-Tri -folderPath $folderPath