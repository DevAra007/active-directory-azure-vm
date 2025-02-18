# Import user data
$users = Import-Csv .\User_List.csv

# Define domain and organizational unit (OU)
$domain = "devdomain.local"
$ouPath = "OU=IT,DC=devdomain,DC=local"

# Create IT Organizational Unit (if it doesn’t exist)
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'IT'")) {
    New-ADOrganizationalUnit -Name "IT" -Path "DC=devdomain,DC=local" -ProtectedFromAccidentalDeletion $false
}

# Loop through users and create accounts
foreach ($user in $users) {
    if ($user.FirstName -and $user.LastName) {
        $username = ($user.FirstName.Substring(0,1) + $user.LastName).ToLower()
        $password = ConvertTo-SecureString "Password1925" -AsPlainText -Force

        New-ADUser -SamAccountName $username `
                   -UserPrincipalName "$username@$domain" `
                   -Name "$($user.FirstName) $($user.LastName)" `
                   -GivenName $user.FirstName `
                   -Surname $user.LastName `
                   -Path $ouPath `
                   -AccountPassword $password `
                   -Enabled $true `
                   -PasswordNeverExpires $true `
                   -ChangePasswordAtLogon $false
    }
}

# Create IT_Department group (if it doesn’t exist)
if (-not (Get-ADGroup -Filter "Name -eq 'IT_Department'")) {
    New-ADGroup -Name "IT_Department" -GroupScope Global -GroupCategory Security -Path $ouPath
}

# Add users in IT OU to IT_Department group
$usersInOU = Get-ADUser -SearchBase $ouPath -Filter *
foreach ($user in $usersInOU) {
    Add-ADGroupMember -Identity "IT_Department" -Members $user
}

Write-Host "User creation and group assignment completed successfully!"
