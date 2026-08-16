$b='iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAAWgmWQ0AAAAASUVORK5CYII='
$names=@('first_member.png','second_member.png','third_member.png','fourth_member.png')
New-Item -ItemType Directory -Force -Path .\assets\avatars | Out-Null
foreach($n in $names) {
    [IO.File]::WriteAllBytes((Join-Path '.\assets\avatars' $n), [Convert]::FromBase64String($b))
}
Write-Host 'Created placeholder PNGs'
