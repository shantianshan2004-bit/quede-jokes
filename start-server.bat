@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Quede Jokes - local preview (close this window to stop)

echo.
echo   Quede Jokes / local preview
echo   ----------------------------------------------------------
echo   If the browser does not open by itself, visit:
echo       http://localhost:8787/
echo.
echo   Why use this instead of double-clicking the .html file?
echo   Serving over http:// lets the page save your uploads and
echo   comments between visits. Opening the file directly still
echo   works, but nothing is kept after you close it.
echo   ----------------------------------------------------------
echo.

timeout /t 1 >nul
start "" http://localhost:8787/

python -m http.server 8787
if errorlevel 1 (
  echo.
  echo   "python" was not found. Trying "py" ...
  py -m http.server 8787
)
if errorlevel 1 (
  echo.
  echo   Python was not found on this computer.
  echo   You can still double-click index.html to view the page.
  echo   Uploads and comments will not be saved in that mode.
)
echo.
echo   Server stopped.
pause
