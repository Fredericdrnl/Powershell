$array = @() # pas bien

class MyObject {
    [string] $cityName
    [string] $pop
    [string] $postalCode
}

$hashtable = @{
    url = "www.toto.fr"
    Method = "GET"
    headers = @{
        Autorisation = "Server access"
    }
    true = "each" # Résultat de la ligne "$hashtable.Add("true", "each")"
}

$requestResponse = Invoke-RestMethod!:  @hashtable

$hashtable.Add("true", "each")

$requestResponse = Invoke-RestMethod -url "www.toto.fr" -Method "GET"


foreach ($response in $requestResponse){
    $myCity = [MyObject]::new()
    $myCity.cityName = $response.name
    $myCity.pop = $response.population
    $myCity.postalCode = $response.code

    $array = $array + $myCity
}

$array | ConvertTo-Csv -Delimiter ";" | Out-File ".\data.csv"