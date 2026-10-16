@echo off
REM ============================================================
REM 看天下政治社 · 一键启动 dev server
REM   - 把 npm 缓存放到 E 盘，不污染 C 盘
REM   - 用受管的 Node 22.22.2-6
REM ============================================================

cd /d "E:\代码成品\网站项目\看天下政治社"

set "PATH=C:\Users\30489\.workbuddy\binaries\node\versions\22.22.2-6;%PATH%"
set "npm_config_cache=E:\代码成品\.npm-cache"
set "TMP=E:\代码成品\.tmp"
set "TEMP=E:\代码成品\.tmp"

echo.
echo [启动] Astro dev server on http://127.0.0.1:4322/
echo   （端口与个人作品集 4321 错开）
echo   （Ctrl + C 可停止）
echo.

npx astro dev --host 127.0.0.1 --port 4322
