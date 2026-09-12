# MoonBit Motion Lab 项目 Git 提交与发布准备脚本

Set-Location $PSScriptRoot

moon fmt --check
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
moon check
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
moon test
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
moon build
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
moon run ./examples/basic
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Verification passed for MoonBit Motion Lab." -ForegroundColor Green
Write-Host "Review the working tree, then commit and push manually." -ForegroundColor Yellow
