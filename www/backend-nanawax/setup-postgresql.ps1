
# Script d'installation PostgreSQL pour Nanawax VIP
# Lancez : powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1

Write-Host "[storage] Configuration PostgreSQL pour Nanawax VIP" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Vérifier si on est administrateur
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
if (-not $isAdmin) {
    Write-Host "[close] Ce script doit être exécuté en tant qu'administrateur" -ForegroundColor Red
    Write-Host "Clic droit sur PowerShell → Exécuter en tant qu'administrateur" -ForegroundColor Yellow
    exit 1
}

# Déterminer le chemin PostgreSQL
$postgresVersions = @("15", "14", "13", "12")
$postgresPath = $null

foreach ($version in $postgresVersions) {
    $path = "C:\Program Files\PostgreSQL\$version\bin\psql.exe"
    if (Test-Path $path) {
        $postgresPath = $path
        Write-Host "[done_all] PostgreSQL $version trouvé" -ForegroundColor Green
        break
    }
}

if (-not $postgresPath) {
    Write-Host "[close] PostgreSQL n'est pas installé" -ForegroundColor Red
    Write-Host "Veuillez installer PostgreSQL depuis https://www.postgresql.org/download/windows/" -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "[build] Création de l'utilisateur et de la base de données..." -ForegroundColor Yellow

# Créer l'utilisateur et la base de données
$sqlScript = @"
CREATE USER nanawax WITH PASSWORD 'nanawax123';
CREATE DATABASE nanawax_vip OWNER nanawax;
GRANT ALL PRIVILEGES ON DATABASE nanawax_vip TO nanawax;
ALTER ROLE nanawax WITH CREATEDB;
"@

# Sauvegarder le script temporaire
$tempScript = [System.IO.Path]::GetTempFileName()
$sqlScript | Out-File -FilePath $tempScript -Encoding UTF8

try {
    # Exécuter le script
    & $postgresPath -U postgres -h localhost -f $tempScript 2>&1
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[done_all] Utilisateur et base de données créés avec succès" -ForegroundColor Green
    } else {
        Write-Host "[warning] Le script s'est exécuté mais vérifiez les erreurs ci-dessus" -ForegroundColor Yellow
    }
} catch {
    Write-Host "[close] Erreur : $_" -ForegroundColor Red
    Write-Host "Assurez-vous que PostgreSQL est en cours d'exécution" -ForegroundColor Yellow
    exit 1
} finally {
    Remove-Item $tempScript -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "[done_all] Vérification de la connexion..." -ForegroundColor Yellow

# Tester la connexion
try {
    $env:PGPASSWORD = "nanawax123"
    & $postgresPath -U nanawax -d nanawax_vip -h localhost -c "SELECT 1" 2>&1 | Out-Null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[done_all] Connexion réussie !" -ForegroundColor Green
    } else {
        Write-Host "[close] Impossible de se connecter à la base de données" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "[close] Erreur : $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "[celebration] Configuration terminée !" -ForegroundColor Green
Write-Host ""
Write-Host "Prochaines étapes :" -ForegroundColor Cyan
Write-Host "1. cd c:\laragon\www\backend-nanawax" -ForegroundColor White
Write-Host "2. npm install" -ForegroundColor White
Write-Host "3. npx prisma migrate deploy" -ForegroundColor White
Write-Host "4. npm start" -ForegroundColor White
Write-Host ""
Write-Host "[bar_chart] Identifiants :" -ForegroundColor Cyan
Write-Host "  Utilisateur : nanawax" -ForegroundColor White
Write-Host "  Mot de passe : nanawax123" -ForegroundColor White
Write-Host "  Base de données : nanawax_vip" -ForegroundColor White
Write-Host ""
