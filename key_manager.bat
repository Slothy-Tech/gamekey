@echo off
title Game Key Inventory Manager
setlocal EnableDelayedExpansion

:menu
cls
echo ===============================
echo   Game Key Inventory Manager  
echo ===============================
echo 1. Add a New Key
echo 2. View Inventory
echo 3. Lock a Key
echo 4. Unlock a Key
echo 5. Exit
echo ===============================
set /p choice="Enter your choice (1-5): "

if "%choice%"=="1" goto add_key
if "%choice%"=="2" goto view_inventory
if "%choice%"=="3" goto lock_key
if "%choice%"=="4" goto unlock_key
if "%choice%"=="5" goto exit
echo Invalid choice! Please try again.
timeout /t 2 >nul
goto menu

:add_key
cls
echo === Add a New Key ===
set /p key="Enter your game key: "
echo %key%>>inventory.txt
echo Key added to inventory!
timeout /t 2 >nul
goto menu

:view_inventory
cls
echo === Your Inventory ===
if not exist inventory.txt (
    echo No keys in inventory yet.
) else (
    type inventory.txt
)
echo.
pause
goto menu

:lock_key
cls
echo === Lock a Key ===
set /p lock_key="Enter the key to lock: "
set /p password="Set a password for this key: "
echo %lock_key%:%password%>locked_key.txt
echo Key locked successfully!
timeout /t 2 >nul
goto menu

:unlock_key
cls
echo === Unlock a Key ===
if not exist locked_key.txt (
    echo No key is currently locked.
    timeout /t 2 >nul
    goto menu
)
set "stored_key="
set "stored_pass="
for /f "tokens=1,2 delims=:" %%a in (locked_key.txt) do (
    set "stored_key=%%a"
    set "stored_pass=%%b"
)
set /p user_pass="Enter the password: "
if "%user_pass%"=="%stored_pass%" (
    echo Key unlocked: %stored_key%
    echo %stored_key%>>inventory.txt
    del locked_key.txt
    echo Key added back to inventory.
) else (
    echo Incorrect password!
)
timeout /t 2 >nul
goto menu

:exit
cls
echo Thanks for using the Game Key Inventory Manager!
timeout /t 2 >nul
exit
