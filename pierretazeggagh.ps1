
# Creer un groupe de ressource
New-AzResourceGroup -Name PIERRETAZEGGAGH -Location eastus 

#Verouiller le groupe de ressource

New-AzResourceLock -LockName nepeutpassupp -LockLevel CanNotDelete -ResourceGroupName PIERRETAZEGGAGH -Force

#comme mariadb est en preversion il faut  executer cette commande avant

Install-Module -Name Az.MariaDb -AllowPrerelease -Force

#Creation du serveur Mariadb 

$securemariadpw = ConvertTo-SecureString '@zeggaghPierret1234' -AsPlainText -Force

New-AzMariaDbServer `
-Name piaze `
-ResourceGroupName PIERRETAZEGGAGH `
-AdministratorLoginPassword $securemariadpw `
-AdministratorUsername 'aymlo' `
-Location eastus `
-Sku 'B_Gen5_1' `
-SslEnforcement Disabled

# Sous-réseaux
New-AzVirtualNetworkSubnetConfig -Name mySubnet -AddressPrefix 192.168.1.0/24 
# Creer un réseaux virtuel 
New-AzVirtualNetwork -ResourceGroupName PIERRETAZEGGAGH -Location eastus -Name myvNet -AddressPrefix 192.168.0.0/16 -Subnet $subnetConfig

#IPPUBLIC 
$myPubIP = New-AzPublicIpAddress -Name mypubip -ResourceGroupName PIERRETAZEGGAGH -Location Eastus -AllocationMethod Static

#IPPUBLICYNOV 
#$Ynovip = New-AzPublicYNovIpAddress -Name ipynov -ResourceGroupName PIERRETAZEGGAGH -Location eastus -AllocationMethod Static

#Creation de la machine virtuelle

$UserName='pieraze'
$securePassword = ConvertTo-SecureString 'AymeneLoic1234' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential($UserName, $securePassword)

New-AzVm `
-ResourceGroupName 'PIERRETAZEGGAGH' `
-Location 'eastus' `
-Name 'pieraze' `
-size 'Standard_B2S' `
-Image UbuntuLTS `
-PublicIpAddressName $myPubIP `
-OpenPorts 443,22, 80, 3306, 1433 `
-GenerateSshKey `
-SshKeyName 'azeggaghpierret' `
-Credential $cred



#Maraidb Pare-feu 

New-AzMariaDbFirewallRule `
-ResourceGroupName PIERRETAZEGGAGH `
-Name firewall-all `
-ServerName piaze `
-AllowAll 

 New-AzMariaDbFirewallRule `
 -ResourceGroupName PIERRETAZEGGAGH `
 -Name publicynov `
 -ServerName piaze `
 -StartIpAddress 77.158.163.10 `
 -EndIpAddress 77.158.163.10


#Pour démarrer le script d'installation de wordpress 


 Invoke-AzVMRunCommand -ResourceGroupName 'PIERRETAZEGGAGH' -Name 'pieraze' -CommandId 'RunShellScript' -ScriptPath 'installer_wordpress.sh'