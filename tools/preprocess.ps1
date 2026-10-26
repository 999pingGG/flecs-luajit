$ErrorActionPreference = 'Stop'
$flecsHeader = './vendor/flecs/flecs.h'
$luaSource = './src/ecs.lua'
$outputDirectory = './distr'

foreach ($path in $flecsHeader, $luaSource, $outputDirectory) {
    if (-not (Test-Path -LiteralPath $path)) {
        Write-Error "Missing $path, make sure to execute this script from the project root."
        exit 1
    }
}

$tempHeader = Join-Path $env:TEMP 'flecs_noinc.h'
Get-Content -LiteralPath $flecsHeader | Where-Object { $_ -notmatch '#include' } | Set-Content -LiteralPath $tempHeader
# FFI declarations need no DLL import/export annotations.
$preprocessed = & cl.exe /nologo /EP /Dflecs_STATIC @args $tempHeader
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}
# HACK: LuaJIT doesn't recognize the `FILE` C type, used in the OS API. So just turn `FILE*` into `void*`.
$cdefs = $preprocessed | Where-Object { $_ -notmatch '#pragma|typedef char bool' } | ForEach-Object { [regex]::Replace($_, '(?<![A-Za-z0-9_])FILE(?![A-Za-z0-9_])', 'void') }
$lua = @("require('ffi').cdef[[") + @($cdefs | Where-Object { $_.Trim() }) + @("]]", '') + @(Get-Content -LiteralPath $luaSource)
$lua | ForEach-Object { $_.TrimEnd() } | Set-Content -LiteralPath "$outputDirectory/ecs.lua" -Encoding utf8
Remove-Item -LiteralPath $tempHeader
