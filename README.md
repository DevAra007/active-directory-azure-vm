<!-- active-directory-azure-vm
Setting up Active Directory on Windows Server 2022 using Azure Virtual Machines -->

<p align="center">
<img src="https://i.imgur.com/APvObZh.png" height="10%" width="40%"alt="Microsoft Active Directory Logo"/>
</p>
<h1>Setup And Configuration Of Active Directory</h1>
This guide shows the implementation of Active Directory in an on-premises enviroment, in this demonstration Azure virtual machines were used to replicate an office enviroment.
I would be creating a video shortly around this guide to show live hands-on.


<h2>Environments and Technologies</h2>

- Azure Virtual Machines (for hosting the AD environment)
- Windows Server 2022 (for Active Directory, DNS, and DHCP)
- Windows 10 Pro (for domain-joined client machines)
- Powershell
- Active Directory Domain Services (AD DS)
- DNS & DHCP Configuration
- Azure Networking (VNet, Subnets, NSGs)

<h2>Steps Of Deployment</h2>

- Azure Resource Setup
- Deploy Windows Server And Win10 VM And Test Connection
- Install Active Directory Domain Services (AD DS)
- Create Users, Organistion and Group with Powershell
- Configure DHCP, DNS and Default Gateway
- Verify Users Access

<h2>Implementations And Deployment</h2>
<br />
<br />
<h3 align="center">Azure Resource Setup</h3>
<br/>

<p>Create Resource Group and create Windows Server and Windows 10 Pro VMs</p>
<p>
  <img src="https://i.imgur.com/qQkxTWd.png" height="65%" width="75%" alt="Resource group"/>
  <img src="https://i.imgur.com/Qce5a45.png" height="65%" width="75%" alt="Win server"/>
  <img src="https://i.imgur.com/1X6avTb.png" height="65%" width="75%" alt="Win10"/>
</p>
<br />
<br />
<p>Make private subnet IP static, enable Ping port on both VM and download RDP file(Optional)</p>
<p>
  <img src="https://i.imgur.com/ivGwbhP.png" height="65%" width="75%" alt="subnet"/>
  <img src="https://i.imgur.com/SK0p32Q.png" height="65%" width="75%" alt="ping port"/>
  <img src="https://i.imgur.com/hacUgWT.png" height="65%" width="75%" alt="rdp file"/>
</p>

<h3 align="center"> Deploy Windows Server And Win10 VM And Test Connection</h3>
<br />

<p> Login with RDP or IP address on Remote Desktop, enable ICMPv4 in both VM firewall for ping and setup DHCP, DNS and DG on Windows Server</p>
<p>
<img src="https://i.imgur.com/wjNLFjV.png" height="65%" width="75%" alt="1-RDP-login"/>
<img src="https://i.imgur.com/TIGLRNG.png" height="65%" width="75%" alt="2-Login-details"/>
<img src="https://i.imgur.com/O01E0tK.png" height="65%" width="75%" alt="3-Successful-Login"/>
<img src="https://i.imgur.com/HsDYbh6.png" height="65%" width="75%" alt="4-Enable-PingFirewall"/>
<img src="https://i.imgur.com/WStjzLV.png" height="75%" width="100%" alt="5-Both-is-pingable"/>
<img src="https://i.imgur.com/Oa5OtH4.png" height="65%" width="75%" alt="6-DC-DHCP-DNS"/>

</p>
<h3 align="center"> Install and configure Active Directory</h3>
<br />

<p> Install Active Directory, promot to Domain controller and add forest</p>
<p>
  <img src="https://i.imgur.com/3DJD2R9.png" height="65%" width="75%" alt="1-Install-AD"/>
<img src="https://i.imgur.com/BrcQQTn.png" height="65%" width="75%" alt="2-PromotDC"/>
<img src="https://i.imgur.com/98jctdp.png" height="65%" width="75%" alt="3-Add-Forest"/>
</p>

<p> Create Domain Controller admin, make user admin and login with user created</p>
<p>
<img src="https://i.imgur.com/egRbad9.png" height="65%" width="75%" alt="4-Create-AdminOU"/>
<img src="https://i.imgur.com/KAxdoFf.png" height="65%" width="75%" alt="5-Create-AdminUser"/>
<img src="https://i.imgur.com/nqbtot4.png" height="65%" width="75%" alt="6-Create-AdminUser"/>
<img src="https://i.imgur.com/7lEWAc0.png" height="65%" width="75%" alt="7-AdminUser-Created"/>
<img src="https://i.imgur.com/Eruawhd.png" height="65%" width="75%" alt="8-MakeUser-Admin"/>
<img src="https://i.imgur.com/lXJ5LYi.png" height="65%" width="75%" alt="9-Login-Devara"/>
<img src="https://i.imgur.com/6MnQNie.png" height="65%" width="75%" alt="10-Login-successful"/>
</p>

<h3 align="center"> Use Powershell to Create User, Group and Organization </h3>
<br />

<p> On Windows Server download Powershell script and user name csv file from https://github.com/DevAra007/active-directory-azure-vm </p>

<p>
  <img src="https://i.imgur.com/MElLjjn.png" height="65%" width="75%" alt="1-Download-files"/>
</p> 
<br />
<p> Open the Powershell script, set execution policy to unrestricted, Navigate to the script and csv folder, run script </p>
<p>
  <img src="https://i.imgur.com/C8SKJu0.png" height="65%" width="75%" alt="2-OpenPSI-Powershell"/>
  <img src="https://i.imgur.com/6HlwS4J.png" height="65%" width="75%" alt="3-Prepare-files-forEX"/>
</p>
<p> Verify that the script runs successfully and confirm the User, Group and Organization was created </p>
<p>
  <img src="https://i.imgur.com/ml84diF.png" height="65%" width="75%" alt="4-Script-Success"/>
  <img src="https://i.imgur.com/BEhRvfy.png" height="65%" width="75%" alt="5-IT-Dpt-User-Created"/>
</p>

<h3 align="center"> Windows 10 Client Network Setup and Join Active Directory Domain </h3>
<br />

<p>Configure Win10 client internet proctocal, DHCP should be client subnet on the network, DNS and Default gateway should reference active directory ip address.</p>

<p>
  <img src="https://i.imgur.com/xXKC34u.png" height="65%" width="75%" alt="1-DHCP-OnWin10"/>
</p>
<br />
<p>Join Win10 client to active directory domain</p>

<p> 
  <img src="https://i.imgur.com/T8kTPWM.png" height="65%" width="75%" alt="1-Set-Domain"/>
  <img src="https://i.imgur.com/dz78OUG.png" height="65%" width="75%" alt="2-Login-DC"/>
  <img src="https://i.imgur.com/GdPYrqx.png" height="65%" width="75%" alt="3-WelcomeTo-Domain"/>
</p>
<br />
<br />

<h3 align="center"> Add Domain Users to Win10 Client and Verify Domain Users Access to Win10 Client</h3>
<br />

<p> Add domain users to Win10 client through Remote Desktop and restart Win10 Client</p>
<p>
  <img src="https://i.imgur.com/1gBrPPX.png" height="65%" width="75%" alt="4-Add-Domain-users-toWin10"/>
  <img src="https://i.imgur.com/3mb1krj.png" height="65%" width="75%" alt="5-Domain-Added"/>
  <img src="https://i.imgur.com/soJLGHU.png" height="65%" width="75%" alt="6-Restart"/>
</p>

<br />

<p> Use one of the domain users credentials to sign into Win10 client</p>

<p>
  <img src="https://i.imgur.com/NhERbP8.png" height="65%" width="75%" alt="7-Choose-A-userCreated"/>
  <img src="https://i.imgur.com/XsLhGRT.png" height="65%" width="75%" alt="8-Signin-with-user"/>
</p>

<p> Lets verify that the users created on the active directory are able to access the Win10 client computer</p>
<p>
  <img src="https://i.imgur.com/WN6JPQQ.png" height="65%" width="75%" alt="9-Verify-user"/>
  <img src="https://i.imgur.com/lCsQ4ra.png" height="65%" width="75%" alt="9-Verify-user2"/>
</p>

<p>The concepts covered shows the creation of Active Directory, promoting it to a Domain controller, creation of the domain name, forest and an admin user, setting network security protocols and ensuring the network link between the Windows server domain controller and the Win10 client computer.</p>
<p>It also shows the use of powershell automation scripts to create 20 users, set passwords, create an organization called IT and also a group. These users were given secure and least privilege access needed to operate the Win10 client and the access was verified.</p>
<p>I would be creating a video shortly around this guide to show live hands-on.</p>
<p>The resources used on Azure was deleted afterwards.</p>



















