#!/bin/bash
# ============================================
# 🎨 NANAWAX VIP - Commandes Rapides
# ============================================
# Fichier helper pour les commandes les plus fréquentes
# Usage: Copiez-collez les commandes selon vos besoins

# ⚡ DÉMARRAGE RAPIDE (1ère fois)
# ============================================
echo "🚀 Démarrage complet du projet"
echo ""
echo "1️⃣  Configurer PostgreSQL:"
powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1
echo ""
echo "2️⃣  Installer npm:"
npm install
echo ""
echo "3️⃣  Initialiser BD:"
npx prisma migrate deploy
echo ""
echo "4️⃣  Démarrer serveur:"
npm start
echo ""
echo "✅ Terminé ! Ouvrez http://localhost:5000/api/health"

# ⚡ DÉMARRAGE SIMPLE (Après 1ère fois)
# ============================================
# cd c:\laragon\www\backend-nanawax
# npm start

# ⚡ MODE DÉVELOPPEMENT (Avec reload auto)
# ============================================
# npm run dev

# ⚡ BASE DE DONNÉES
# ============================================
# Voir l'interface GUI:
# npx prisma studio

# Réinitialiser complètement:
# npx prisma migrate reset --force

# Créer une migration:
# npx prisma migrate dev --name nom_migration

# Générer client Prisma:
# npx prisma generate

# ⚡ POSTGRESQL
# ============================================
# Se connecter à la BD:
# psql -U nanawax -d nanawax_vip -h localhost

# Lister les tables:
# psql -U nanawax -d nanawax_vip -h localhost -c "\dt"

# Sauvegarder la BD:
# pg_dump -U nanawax nanawax_vip > backup.sql

# Restaurer la BD:
# psql -U nanawax nanawax_vip < backup.sql

# ⚡ DÉPANNAGE
# ============================================
# Nettoyer et réinstaller:
# rm -r node_modules
# npm install

# Vérifier les erreurs:
# npm audit

# Mettre à jour les packages:
# npm update
# npm install

# Chercher l'erreur:
# npm run dev    # Lance en mode debug avec output

# ⚡ VÉRIFICATIONS
# ============================================
# Vérifier Node.js:
# node --version

# Vérifier npm:
# npm --version

# Vérifier PostgreSQL:
# psql --version

# Health check API:
# curl http://localhost:5000/api/health

# ⚡ SCRIPTS NPM DISPONIBLES
# ============================================
# npm start              - Production
# npm run dev            - Développement
# npm run prisma:generate - Générer Prisma
# npm run prisma:migrate  - Créer migration
# npm run prisma:deploy   - Déployer migrations
# npm run prisma:reset    - Réinitialiser BD
# npm run prisma:studio   - Interface GUI
# npm test              - Tests

echo ""
echo "💡 Pour plus de commandes, consultez:"
echo "   - START_HERE.md"
echo "   - QUICK_START.md"
echo "   - README.md"
