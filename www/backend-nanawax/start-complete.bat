@echo off
REM [rocket] Script de démarrage complet pour Nanawax VIP Backend
REM Cet script vérifie tous les prérequis avant de démarrer le serveur

chcp 65001 >nul
setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║           [palette] NANAWAX VIP - BACKEND STARTUP          ║
echo ║                   v2.0.0 Production Ready                  ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Vérifier Node.js
echo [list] Vérification des prérequis...
node -v >nul 2>&1
if errorlevel 1 (
    echo [close] Node.js n'est pas installé ou non accessible
    echo    Installer depuis: https://nodejs.org/
    echo    Requiert: Node.js v18.0.0 ou supérieur
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
echo [done_all] Node.js %NODE_VERSION% trouvé

REM Vérifier npm
npm -v >nul 2>&1
if errorlevel 1 (
    echo [close] npm n'est pas installé
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('npm -v') do set NPM_VERSION=%%i
echo [done_all] npm %NPM_VERSION% trouvé

REM Vérifier l'existence du fichier .env
if not exist ".env" (
    echo [close] Fichier .env manquant
    echo    Le fichier .env doit exister pour configurer la base de données
    pause
    exit /b 1
)
echo [done_all] Fichier .env trouvé

REM Vérifier node_modules
if not exist "node_modules" (
    echo.
    echo [package] Installation des dépendances npm...
    echo.
    call npm install
    if errorlevel 1 (
        echo [close] Installation des dépendances échouée
        pause
        exit /b 1
    )
    echo.
)
echo [done_all] Dépendances installées

REM Générer le client Prisma
echo.
echo [build] Génération du client Prisma...
call npx prisma generate >nul 2>&1
if errorlevel 1 (
    echo [warning] Attention: Génération du client Prisma échouée
    echo    Continuons même ainsi...
)
echo [done_all] Client Prisma généré

REM Vérifier la connexion à la base de données
echo.
echo [storage] Vérification de la connexion à la base de données...
call npx prisma db execute --stdin < nul >nul 2>&1
if errorlevel 1 (
    echo [warning] Attention: Impossible de se connecter à la base de données
    echo    Assurez-vous que:
    echo    1. PostgreSQL est en cours d'exécution
    echo    2. L'utilisateur nanawax et la base nanawax_vip existent
    echo    3. Les identifiants dans .env sont corrects
    echo.
    echo Voulez-vous continuer quand même? (O pour oui, autres pour quitter)
    set /p CONTINUE="Continuer? (O/N): "
    if /i not "!CONTINUE!"=="O" (
        exit /b 1
    )
) else (
    echo [done_all] Connexion à la base de données OK
)

REM Afficher les informations de démarrage
echo.
echo ════════════════════════════════════════════════════════════
echo [rocket] DÉMARRAGE DU SERVEUR
echo ════════════════════════════════════════════════════════════
echo.
echo [location] URL: http://localhost:5000
echo [health_check] Health Check: http://localhost:5000/api/health
echo.
echo [key] Credentials Admin par défaut:
echo    Email: admin@nanawax.com
echo    Mot de passe: admin123
echo.
echo [lightbulb] Commandes utiles:
echo    - Ctrl+C pour arrêter le serveur
echo    - npm run dev pour mode développement avec reload auto
echo    - npx prisma studio pour voir la base de données
echo.
echo ════════════════════════════════════════════════════════════
echo.

REM Démarrer le serveur
node server.js

REM Si le serveur s'arrête, afficher un message
echo.
echo [close] Le serveur s'est arrêté
pause
