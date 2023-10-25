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
    sans affichage .\Get-TriAnalyse.ps1 -folderPath .\test
    avec affichage .\Get-TriAnalyse.ps1 -folderPath .\test -Verbose
#>

param (
    [Parameter(Mandatory=$true)]
    [string] $folderPath 
)

function Get-TriAnalyse {

    param (
        [Parameter(Mandatory=$true)]
        [string] $folderPath 
    )
    
    begin {
        Write-Verbose $PSBoundParameters['folderPath']
        try {

            # Take files on the folder 
            $filesDirectory = Get-ChildItem -Path $PSBoundParameters['folderPath'] -Recurse
            $pathFilesDirectory = Get-ChildItem -Path ($PSBoundParameters['folderPath']) -Recurse | %{$_.FullName}
            Write-Verbose "Le dossier à été trouvé"

        } catch {
            Write-Error "Le chemin spécifié en paramètre est invalide"
            throw "Le chemin spécifié en paramètre est invalide"
        }

        #Test if folders exist
        if (!(Test-Path "$($PSBoundParameters['folderPath'])\Analyse-image")){
            New-Item "$($PSBoundParameters['folderPath'])\Analyse-image" -itemType Directory
            Write-Verbose "Dossier Analyse image cree"
        }

        if (!(Test-Path "$($PSBoundParameters['folderPath'])\Analyse-video")){
            New-Item "$($PSBoundParameters['folderPath'])\Analyse-video" -itemType Directory
            Write-Verbose "Dossier Analyse video cree"
        }

        if (!(Test-Path "$($PSBoundParameters['folderPath'])\Analyse-document")){
            New-Item "$($PSBoundParameters['folderPath'])\Analyse-document" -itemType Directory
            Write-Verbose "Dossier Analyse document cree"
        }

        if (!(Test-Path "$($PSBoundParameters['folderPath'])\Analyse-programme")){
            New-Item "$($PSBoundParameters['folderPath'])\Analyse-programme" -itemType Directory
            Write-Verbose "Dossier Analyse programme cree"
        }
    }
     
    process {

        $i = 0 
        # For each file
        foreach ($file in $filesDirectory){

            # Get extension of $file
            $extension =[System.IO.Path]::GetExtension($file)
            $path = Get-ChildItem -Path ($PSBoundParameters['folderPath']) -Filter "$($file)" -Recurse | %{$_.FullName}

            # If image file
            if (($extension -ilike ".jpg") -or ($extension -ilike ".png") -or ($extension -ilike ".gif") -or ($extension -ilike ".svg")) {  
                try {
                    Copy-Item "$($path)" -Destination "$($PSBoundParameters['folderPath'])\Analyse-image"
                    Write-Verbose "Le fichier $($file) a été copié dans analyse-image"
                }
                catch {
                    Write-Error "Le fichier n'a pas pu être copié dans Analyse-image"
                    throw "Le fichier n'a pas pu être copié dans Analyse-image"
                }
            }

            # If video file
            if (($extension -ilike ".mkv") -or ($extension -ilike ".mp4")) {
                try {
                    Copy-Item "$($path)" -Destination "$($PSBoundParameters['folderPath'])\Analyse-video"
                    Write-Verbose "Le fichier $($file) a été copié dans analyse-video"
                }
                catch {
                    Write-Error "Le fichier n'a pas pu être copié dans Analyse-video"
                    throw "Le fichier n'a pas pu être copié dans Analyse-video"
                }
            }

            # If document file
            if (($extension -ilike ".docx") -or ($extension -ilike ".csv") -or ($extension -ilike ".json") -or ($extension -ilike ".txt")) {
                try {
                    Copy-Item "$($path)" -Destination "$($PSBoundParameters['folderPath'])\Analyse-document"
                    Write-Verbose "Le fichier $($file) a été copié dans analyse-document"
                }
                catch {
                    Write-Error "Le fichier n'a pas pu être copié dans Analyse-document"
                    throw "Le fichier n'a pas pu être copié dans Analyse-document"
                }
            }

            # If program file
            if (($extension -ilike ".dll") -or ($extension -ilike ".exe")){
                try {
                    Copy-Item "$($path)" -Destination "$($PSBoundParameters['folderPath'])\Analyse-programme"
                    Write-Verbose "Le fichier $($file) a été copié dans analyse-programme"
                }
                catch {
                    Write-Error "Le fichier n'a pas pu être copié dans Analyse-programme"
                    throw "Le fichier n'a pas pu être copié dans Analyse-programme"
                }
            }
        $i++;
        }
    }
    
    end {
        Write-Verbose "Execution du programme terminé"
    }
}

$filesDirectory = Get-TriAnalyse -folderPath $folderPath