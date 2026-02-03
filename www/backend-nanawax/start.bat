@echo off
REM ============================================
REM Script de démarrage rapide - Nanawax VIP Backend
REM ============================================

echo.
echo [palette] Nanawax VIP - Backend Startup
echo ============================================
echo.

REM Vérifier Node.js
where node >nul 2>nul
if errorlevel 1 (
    echo [close] Node.js n'est pas installé ou pas dans PATH
    echo Téléchargez-le depuis https://nodejs.org/
    pause
    exit /b 1
)

echo [done_all] Node.js trouvé
node --version

REM Vérifier npm
where npm >nul 2>nul
if errorlevel 1 (
    echo [close] npm n'est pas installé
    pause
    exit /b 1
)

echo [done_all] npm trouvé
npm --version
echo.

REM Vérifier si node_modules existe
if not exist "node_modules" (
    echo [package] Installation des dépendances...
    echo.
    call npm install
    if errorlevel 1 (
        echo [close] Erreur lors de l'installation des dépendances
        pause
        exit /b 1
    )
    echo.
)

REM Vérifier .env
if not exist ".env" (
    echo [warning] Fichier .env non trouvé!
    echo Créez le fichier .env avec votre configuration de base de données
    pause
    exit /b 1
)

echo [done_all] Configuration trouvée
echo.
echo [rocket] Démarrage du serveur...
echo ============================================
echo.

REM Générer Prisma Client
npx prisma generate

REM Lancer le serveur
npm start

pause
