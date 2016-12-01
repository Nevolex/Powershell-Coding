<# ----  Script for any AD Object query. Here: (anr=levch) - 	it can be written any quantity of symbols and 
	for any type of objects - PCs, users, groups.  Enjoy :)  ---- #>

Get-ADObject -LDAPFilter:"(anr=bots)" -Properties * | select Name,displayName,description,mail,telephoneNumber,`
department,employeeID,extensionAttribute8,ipPhone,ObjectClass,whenChanged,`
@{n='pwdLastSet';e={[DateTime]::FromFileTime($_.pwdLastSet)}},`
@{n='lastLogonTimestamp';e={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},`
lastLogoff,groupType,objectSid #| ogv



<# ----		in addition, more limited type of queries:	---- #>
#Get-ADUser  -ldapfilter "(displayname=vege*)" -Property * | Select  -Property extensionAttribute8, Mail
#Get-ADUser  -ldapfilter "(displayname=rudes*)" -Property * | select   -Property Name, DisplayName, Mail, extensionAttribute8, EmployeeID, Department, Description, ipPhone #| Out-GridView

#Get-ADUser -Identity vegera01 -Property * | Select  -Property extensionAttribute8

###  Also  ###
#Get-ADUser  -ldapfilter "(displayname=musi*)" -Property * | Select  -Property DisplayName
<#
$Prop = [ordered]@{}  
 $Prop.DisplayName =([adsisearcher]"(anr=vegera01)").FindOne().Properties['displayname']  
 $Prop.FirstName = ([adsisearcher]"(anr=bshwjt)").FindOne().Properties['GivenName'] 
 $Prop.LastName = ([adsisearcher]"(anr=bshwjt)").FindOne().Properties['SN'] 
 $Prop.Manager = ([adsisearcher]"(anr=bshwjt)").FindOne().Properties['Manager']  
 $Prop.Manager = ([adsisearcher]"(anr=bshwjt)").FindOne().Properties['Mail']  
 New-Object PSObject -property $Prop | FL
  
 <#  userAccountControl,info,badPasswordTime,otherTelephone,modifyTimeStamp,
 createTimeStamp,DistinguishedName       #>
#>