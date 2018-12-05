<#
.SYNOPSIS
    Script to change UserPrincipalName to FSurname@domain.com
.DESCRIPTION
    Use when not in a hybrid environment as there are better scripts available
    Ensure that OU is changed
.EXAMPLE
    PS C:\> <example usage>
    Explanation of what the example does
.INPUTS
    Inputs (if any)
.OUTPUTS
    Output (if any)
.NOTES
    Based on the original work from 
        Brandon Marcus - brandon@brandonmarc.us
    Edited to just use first initial of Firstname.
#>
 
    Get-ADUser -Filter * -SearchBase "OU=Test Accounts,OU=User Accounts,DC=domain,DC=com" | ForEach-Object {  
      
    $fn = $_.givenName.replace(" ","")
    $ln = $_.surname.replace(" ","")

    $fn = $fn.Substring(0,1)
    $suffix = "domain.com"
    $upn = "$fn$ln@$suffix"
      
    Write-Host $fn$ln
    Write-Host $upn
      
    set-aduser $_ -UserPrincipalName $upn
      
    }