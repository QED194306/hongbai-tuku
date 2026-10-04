# 从 original/ 生成 docs/ 下的网页版图片（2000px 宽，基本无损 PNG）。
# 用法: pwsh -File tools/resize.ps1

param(
    [int]$Width = 2000
)

Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$srcDir = Join-Path $root "original"
$dstDir = Join-Path $root "docs"

if (-not (Test-Path $srcDir)) {
    throw "找不到 $srcDir，请先把原始图片放进去。"
}

Get-ChildItem $srcDir -File | Where-Object { $_.Extension -match '^\.(png|jpg|jpeg)$' } | ForEach-Object {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    $w = [Math]::Min($Width, $img.Width)
    $h = [int][Math]::Round($img.Height * $w / $img.Width)

    $bmp = New-Object System.Drawing.Bitmap $w, $h, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.CompositingMode = 'SourceCopy'
    $g.InterpolationMode = 'HighQualityBicubic'
    $g.PixelOffsetMode = 'HighQuality'
    $g.SmoothingMode = 'HighQuality'
    $g.DrawImage($img, (New-Object System.Drawing.Rectangle 0, 0, $w, $h))
    $g.Dispose()

    $out = Join-Path $dstDir ($_.BaseName + ".png")
    $bmp.Save($out, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    $img.Dispose()

    Write-Host ("{0} -> {1} ({2}x{3})" -f $_.Name, (Split-Path -Leaf $out), $w, $h)
}
