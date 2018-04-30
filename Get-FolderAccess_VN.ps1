#  Script for getting Accesses on folders with defined columns
#  Date: 11.04.2018
#  Modified: 13.04.2018
#  Version: 0.8

$dirs = (Get-ChildItem "\\uapefs002\vol1" -recurse | where {$_.PSIsContainer -eq $true})
foreach ($dir in $dirs) {
    $ObjAccess = (Get-ACL $dir.FullName)
    $ObjAccess.Access | `
        Where {$_.IdentityReference -NotLike "*PEFS_ALL*" `
            -and $_.IdentityReference -NotLike "*Пользователи*" `
            -and $_.IdentityReference -NotLike "*KOSTALDE*"`
            -and $_.IdentityReference -NotLike "*NT AUTHORITY*"`
            -and $_.IdentityReference -NotLike "*Администраторы*"`
            -and $_.IdentityReference -NotLike "*FS_NO_Write*"
        } | `
        Foreach {
            $obj = New-Object PSObject
            $Obj | Add-Member NoteProperty Path $ObjAccess.Path.Split('::')[2]
            $Obj | Add-Member NoteProperty Name $_.IdentityReference.Value.split("\")[1]
            $Right = $_.FilesystemRights
                if ($Right -like "*modify*") {
                    $RightOut = "Modify"
                } 
                elseif ($Right -like "read*") {
                    $RightOut = "Read"
                } 
                elseif ($Right -like "*full*") {
                    $RightOut = "FullControl"
                }
                else {
                    $RightOut = "Test"
                }
            $Obj | Add-Member NoteProperty FilesystemRights $RightOut
            $Obj
    } | Export-Csv -Path "D:\Temp_VN\FolderAccess_VOL1_v1_$(Get-Date -f dd.MM.yyyy).csv" -Del ";" -App -Enc utf8 -noType
}