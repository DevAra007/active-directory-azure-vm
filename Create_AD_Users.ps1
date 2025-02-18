# Import user data
$users = Import-Csv .\User_List.csv -Header FirstName,LastName

# Create IT Organizational Unit
New-ADOrganizationalUnit -Name "IT"

# Loop through users and create accounts
foreach ($user in $users) {
    $username = ($user.FirstName.Substring(0,1) + $user.LastName).ToLower()
    New-ADUser -SamAccountName $username `
               -UserPrincipalName "$username@mydomain.local" `
               -Name "$($user.FirstName) $($user.LastName)" `
               -GivenName $user.FirstName `
               -Surname $user.LastName `
               -Path "OU=IT,DC=mydomain,DC=local" `
               -AccountPassword (ConvertTo-SecureString "pass1925" -AsPlainText -Force) `
               -Enabled $true
}

# Create IT_Department group
New-ADGroup -Name "IT_Department" -GroupScope Global

# Add users to IT_Department group
Get-ADUser -Filter * | Where-Object { $_.DistinguishedName -like "*OU=IT,*" } | 
    ForEach-Object { Add-ADGroupMember -Identity "IT_Department" -Members $_ }
