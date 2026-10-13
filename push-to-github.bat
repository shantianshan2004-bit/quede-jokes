@echo off
chcp 65001 >nul
cd /d "%~dp0"
title Push to GitHub - quede-jokes

echo.
echo   ============================================================
echo    Push to GitHub  -  Quede Jokes
echo   ============================================================
echo.
echo   This uploads the project code to your GitHub repository.
echo.
echo   The FIRST time, a browser window will open and ask you to
echo   log in to GitHub. After you approve, the push continues by
echo   itself - just leave this window open.
echo.

git remote get-url origin >nul 2>&1
if not errorlevel 1 goto have_remote
goto ask_url

:ask_url
echo   ------------------------------------------------------------
echo    First run. Paste your GitHub repository URL and press Enter.
echo.
echo    It looks like:
echo      https://github.com/YOUR-NAME/quede-jokes.git
echo.
echo    Note: create the repository on github.com FIRST, and leave
echo    it EMPTY (no README, no .gitignore). Otherwise the push is
echo    rejected.
echo   ------------------------------------------------------------
echo.
set "REPOURL="
set /p "REPOURL=Repo URL: "
if "%REPOURL%"=="" goto no_url
git remote add origin "%REPOURL%"
echo.
goto push

:have_remote
echo   Remote already configured:
echo.
git remote -v
echo.

:push
git branch -M main
echo.
echo   Pushing to GitHub ...
echo.
git push -u origin main
if errorlevel 1 goto failed

echo.
echo   ============================================================
echo    Done. Your code is now on GitHub.
echo   ============================================================
echo.
echo   Next: turn on GitHub Pages so you get a shareable link.
echo   On the repo page go to Settings - Pages - Source: main - Save.
echo.
pause
exit /b 0

:no_url
echo.
echo   No URL entered, so nothing was done.
echo.
pause
exit /b 1

:failed
echo.
echo   Push failed. The usual reasons, in order:
echo.
echo     1. The repository does not exist on GitHub yet.
echo     2. The repository was created WITH a README, so GitHub and
echo        this folder have different histories. Easiest fix: delete
echo        that repo and create a new empty one.
echo     3. You closed the login window instead of approving.
echo     4. The URL has a typo.
echo.
echo   To correct the URL later, run this in this folder:
echo      git remote set-url origin https://github.com/USER/REPO.git
echo.
pause
exit /b 1
