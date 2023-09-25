function Get-tri {

    param (
        [Parameter(Mandatory=$true)]
        [string] $folderPath 
    )
    
    Write-Host $folderPath
    # Take files on the folder 
    $filesDL = Get-ChildItem -Path $folderPath -Force

    # For each file
    foreach ($file in $filesDL){

        # Get extension of the file
        $extension =[System.IO.Path]::GetExtension($file)

        # If the fil
        if (!($extension -like $file)){
            
            # If the file isn't a folder
            if (!($extension -like "")){
                Write-Host "$($extension)"
                Write-Host "$($folderPath)\$extension"
                
                #IF the folder exist
                if (!(Test-Path "$($folderPath)\$($extension)")){
                    New-Item "$($folderPath)\$extension" -itemType Directory
                }

                # Copy and paste file
                Copy-Item "$($folderPath)\$($file)" -Destination "$($folderPath)\$extension" 
                Remove-Item -Path "$($folderPath)\$($file)"
            }
        }
    }
}