@echo off
REM ============================================================
REM 看天下政治社 · 一键安装依赖
REM   - 把 npm 缓存放到 E 盘，不污染 C 盘
REM   - 用受管的 Node 22.22.2-6
REM ============================================================

cd /d "E:\代码成品\网站项目\看天下政治社"

set "PATH=C:\Users\30489\.workbuddy\binaries\node\versions\22.22.2-6;%PATH%"
set "npm_config_cache=E:\代码成品\.npm-cache"
set "TMP=E:\代码成品\.tmp"
set "TEMP=E:\代码成品\.tmp"

echo.
echo [安装] npm 缓存目录: %npm_config_cache%
echo [安装] 临时目录: %TMP%
echo.

call npm install --no-audit --no-fund

echo.
if %errorlevel%==0 (
  echo [完成] 依赖装好了。下一步执行"启动网站.bat"
) else (
  echo [失败] 安装未成功，请把上面报错截图给统筹
)
echo.
pause
