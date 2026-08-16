Set-Location 'C:\workspace\student_dashboard'
$commitMessage = 'Fix run script parsing; add web support and local avatar placeholders; update main.dart to use local PNG avatars'
$inside = $false
try {
    git rev-parse --is-inside-work-tree | Out-Null
    $inside = $true
} catch {
    $inside = $false
}
if ($inside) {
    git add -A
    git commit -m $commitMessage
} else {
    git init
    git add -A
    git commit -m $commitMessage
}
git --no-pager log -n 5 --oneline
