# axuse 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/ctoldigital/axuse#quick-start
# 更新日期：2026-10-30
# 类型：script
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw '需要先安装 Git' }
if (-not (Get-Command node -ErrorAction SilentlyContinue)) { throw '需要先安装 Node.js' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

git clone https://github.com/ctoldigital/axuse.git
Set-Location axuse
node src/cli.js doctor
node src/cli.js print-config --harness generic
Write-Host "把配置块里的命令换成 src/cli.js 的绝对路径，再注册到你的客户端"

Write-Host ''

Write-Host '安装完成：让 Agent 试着打开一个网页并读无障碍快照；换客户端时用 print-config 生成对应配置块'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/ctoldigital/axuse#quick-start'
