Add-Type -AssemblyName System.Drawing

$inputFolder = Join-Path $PSScriptRoot '..\assets\avatars'
$outputFolder = Join-Path $PSScriptRoot '..\assets\dartpad_avatars'
New-Item -ItemType Directory -Force -Path $outputFolder | Out-Null

Get-ChildItem -LiteralPath $inputFolder -Filter '*.png' | ForEach-Object {
    $source = [System.Drawing.Image]::FromFile($_.FullName)
    $side = [Math]::Min($source.Width, $source.Height)
    $left = [int](($source.Width - $side) / 2)
    $top = [int](($source.Height - $side) / 2)

    $thumbnail = New-Object System.Drawing.Bitmap 96, 96
    $graphics = [System.Drawing.Graphics]::FromImage($thumbnail)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.DrawImage($source, [System.Drawing.Rectangle]::new(0, 0, 96, 96), $left, $top, $side, $side, [System.Drawing.GraphicsUnit]::Pixel)

    $outputPath = Join-Path $outputFolder ($_.BaseName + '.jpg')
    $thumbnail.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)

    $graphics.Dispose()
    $thumbnail.Dispose()
    $source.Dispose()
}
