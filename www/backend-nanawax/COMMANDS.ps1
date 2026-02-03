# ============================================
# 🎨 NANAWAX VIP - Commandes Rapides PowerShell
# ============================================
# Script helper pour les commandes les plus fréquentes
# Usage: Copiez-collez les commandes selon vos besoins

Write-Host "🎨 NANAWAX VIP - Commandes Rapides" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# Fonction pour afficher les catégories
function Show-Category {
    param([string]$title)
    Write-Host ""
    Write-Host "⚡ $title" -ForegroundColor Yellow
    Write-Host "─" * 50 -ForegroundColor Gray
}

# ⚡ DÉMARRAGE RAPIDE (1ère fois)
Show-Category "DÉMARRAGE COMPLET (1ère fois)"
@"
1️⃣  Configurer PostgreSQL:
    powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1

2️⃣  Installer npm:
    npm install

3️⃣  Initialiser BD:
    npx prisma migrate deploy

4️⃣  Démarrer serveur:
    npm start

✅ Terminé ! Ouvrez http://localhost:5000/api/health
"@ | Write-Host -ForegroundColor White

# ⚡ DÉMARRAGE SIMPLE
Show-Category "DÉMARRAGE SIMPLE (Après 1ère fois)"
@"
cd c:\laragon\www\backend-nanawax
npm start
"@ | Write-Host -ForegroundColor White

# ⚡ MODE DÉVELOPPEMENT
Show-Category "MODE DÉVELOPPEMENT (Avec reload auto)"
@"
npm run dev
"@ | Write-Host -ForegroundColor White

# ⚡ BASE DE DONNÉES
Show-Category "COMMANDES BASE DE DONNÉES"
@"
📊 Voir l'interface GUI:
    npx prisma studio

♻️  Réinitialiser complètement (⚠️ Efface les données):
    npx prisma migrate reset --force

➕ Créer une migration:
    npx prisma migrate dev --name nom_migration

🔧 Générer client Prisma:
    npx prisma generate

📊 Voir les tables:
    npx prisma db push
"@ | Write-Host -ForegroundColor White

# ⚡ POSTGRESQL
Show-Category "COMMANDES POSTGRESQL"
@"
🗄️  Se connecter à la BD:
    psql -U nanawax -d nanawax_vip -h localhost

📋 Lister les tables:
    psql -U nanawax -d nanawax_vip -h localhost -c "\dt"

💾 Sauvegarder la BD:
    pg_dump -U nanawax nanawax_vip > backup.sql

📥 Restaurer la BD:
    psql -U nanawax nanawax_vip < backup.sql

🔄 Redémarrer PostgreSQL:
    Restart-Service PostgreSQL-x64-15
"@ | Write-Host -ForegroundColor White

# ⚡ DÉPANNAGE
Show-Category "DÉPANNAGE"
@"
🧹 Nettoyer et réinstaller:
    rm -r node_modules
    npm install

🔍 Vérifier les erreurs:
    npm audit

📦 Mettre à jour les packages:
    npm update
    npm install

🐛 Mode debug:
    npm run dev

🔧 Réinstaller tout:
    npm ci
"@ | Write-Host -ForegroundColor White

# ⚡ VÉRIFICATIONS
Show-Category "VÉRIFICATIONS"
@"
✅ Vérifier Node.js:
    node --version          (Doit être v18+)

✅ Vérifier npm:
    npm --version           (Doit être 8+)

✅ Vérifier PostgreSQL:
    psql --version          (Doit être 12+)

✅ Health check API:
    curl http://localhost:5000/api/health

✅ Vérifier ports:
    netstat -ano | findstr :5000
"@ | Write-Host -ForegroundColor White

# ⚡ SCRIPTS NPM DISPONIBLES
Show-Category "SCRIPTS NPM DISPONIBLES"
@"
npm start                   Production
npm run dev                 Développement avec reload
npm run prisma:generate    Générer Prisma client
npm run prisma:migrate     Créer une migration
npm run prisma:deploy      Déployer les migrations
npm run prisma:reset       Réinitialiser BD
npm run prisma:studio      Interface GUI Prisma
"@ | Write-Host -ForegroundColor White

# ⚡ FICHIERS DE CONFIGURATION
Show-Category "FICHIERS IMPORTANTS"
@"
📄 .env                    Variables d'environnement
📄 package.json            Dépendances Node.js
📄 prisma/schema.prisma   Schéma base de données
📄 server.js               Serveur principal
📄 src/middleware/auth.js  Authentification
📄 src/routes/auth.js      Routes d'auth
"@ | Write-Host -ForegroundColor White

# ⚡ DOCUMENTATION
Show-Category "DOCUMENTATION"
@"
📚 START_HERE.md           Commencez ici!
📚 QUICK_START.md          Démarrage rapide
📚 README.md               Documentation complète
📚 POSTGRESQL_SETUP.md     Setup PostgreSQL
📚 CHECKLIST.md            Checklist de vérification
"@ | Write-Host -ForegroundColor White

# ⚡ ACCÈS RAPIDES
Show-Category "ACCÈS RAPIDES"
@"
🌐 Frontend:               file:///c:/laragon/www/index.html
🔗 API:                    http://localhost:5000/api
🏥 Health Check:           http://localhost:5000/api/health
📊 Prisma Studio:          npx prisma studio
⚙️  Setup Page:            file:///c:/laragon/www/SETUP.html
"@ | Write-Host -ForegroundColor White

# ⚡ IDENTIFIANTS
Show-Category "IDENTIFIANTS PAR DÉFAUT"
Write-Host "Email:    " -ForegroundColor Green -NoNewline
Write-Host "admin@nanawax.com" -ForegroundColor White
Write-Host "Mot de passe: " -ForegroundColor Green -NoNewline
Write-Host "admin123" -ForegroundColor White
Write-Host ""
Write-Host "⚠️  À changer après la première connexion !" -ForegroundColor Yellow

# ⚡ ASSISTANT
Show-Category "BESOIN D'AIDE ?"
Write-Host ""
Write-Host "1. Consultez la section 'Dépannage Rapide' du README" -ForegroundColor Cyan
Write-Host "2. Vérifiez les logs du serveur" -ForegroundColor Cyan
Write-Host "3. Lancez la checklist: CHECKLIST.md" -ForegroundColor Cyan
Write-Host "4. Consultez QUICK_START.md pour les étapes" -ForegroundColor Cyan
Write-Host ""

Write-Host "✨ Bon développement avec Nanawax VIP !" -ForegroundColor Green
