# ✅ CHECKLIST DE VÉRIFICATION - Nanawax VIP

## 📋 Vérifier l'Installation Complète

Utilisez cette checklist pour vous assurer que tout est configuré correctement.

---

## ✅ Fichiers et Dossiers Nécessaires

### Frontend (c:\laragon\www\)
- [ ] `index.html` - Application frontend (⭐ Principal)
- [ ] `config.js` - Configuration frontend
- [ ] `SETUP.html` - Page de setup
- [ ] `README.md` - Documentation maître
- [ ] `.htaccess` (optionnel) - Configuration Apache

### Backend (c:\laragon\www\backend-nanawax\)
- [ ] `server.js` - Serveur principal
- [ ] `package.json` - Dépendances npm
- [ ] `.env` - Variables d'environnement
- [ ] `.gitignore` - Configuration Git
- [ ] `node_modules/` - Dépendances installées (après npm install)

### Scripts et Documentation
- [ ] `start.bat` - Script de démarrage simple
- [ ] `start-complete.bat` - Script avancé avec vérifications
- [ ] `setup-postgresql.ps1` - Configuration PostgreSQL
- [ ] `START_HERE.md` - Guide de démarrage
- [ ] `QUICK_START.md` - Démarrage rapide
- [ ] `README.md` - Documentation backend
- [ ] `POSTGRESQL_SETUP.md` - Guide PostgreSQL

### Code Source
- [ ] `src/middleware/auth.js` - Authentification
- [ ] `src/routes/auth.js` - Routes auth
- [ ] `prisma/schema.prisma` - Schéma BD
- [ ] `prisma/init.sql` - Initialisation SQL

---

## ✅ Prérequis Système

### Installations Globales
- [ ] **Node.js 18+** - `node --version` (Doit être v18.0.0+)
- [ ] **npm 8+** - `npm --version` (Doit être 8.0.0+)
- [ ] **PostgreSQL 12+** - Services ou ligne de commande
- [ ] **PowerShell** - Pour exécuter les scripts

### Vérification
```powershell
node --version      # v18.x.x ou plus
npm --version       # 8.x.x ou plus
psql --version      # 12.x ou plus
```

---

## ✅ Configuration Backend

### Fichier .env
Vérifiez que `.env` contient:

```env
# Port et environnement
PORT=5000
NODE_ENV=development

# Base de données
DATABASE_URL="postgresql://nanawax:nanawax123@localhost:5432/nanawax_vip"

# JWT
JWT_SECRET=your_secret_jwt_key_change_in_production
JWT_EXPIRES_IN=7d

# Frontend
FRONTEND_URL=http://localhost:3000
```

**Checklist:**
- [ ] Fichier `.env` existe dans `/backend-nanawax/`
- [ ] `DATABASE_URL` est configuré
- [ ] `JWT_SECRET` est défini (minimum 32 caractères)
- [ ] `PORT` est défini (par défaut 5000)
- [ ] `NODE_ENV` est configuré

---

## ✅ Configuration PostgreSQL

### Base de Données
- [ ] PostgreSQL est installé et en cours d'exécution
- [ ] L'utilisateur `nanawax` existe
- [ ] La base de données `nanawax_vip` existe
- [ ] L'utilisateur `nanawax` a les droits sur `nanawax_vip`

### Vérification
```powershell
# Se connecter à PostgreSQL
psql -U nanawax -d nanawax_vip -h localhost

# Devrait afficher: nanawax_vip=>
# Si yes, tout est bon! Si non, reconfigurez avec setup-postgresql.ps1
```

**Commandes utiles:**
```sql
-- Vérifier les utilisateurs
\du

-- Vérifier les bases
\l

-- Quitter
\q
```

---

## ✅ Installation des Dépendances

### Vérifier npm install
```powershell
cd c:\laragon\www\backend-nanawax
npm install
```

- [ ] Commande complétée sans erreurs
- [ ] Dossier `node_modules/` créé
- [ ] Fichier `package-lock.json` créé
- [ ] Tous les packages listés dans `package.json` sont installés

### Packages clés à vérifier
```powershell
npm list express       # Doit être 4.18.x
npm list prisma        # Doit être 5.0.x
npm list jsonwebtoken  # Doit être 9.0.x
npm list bcryptjs      # Doit être 2.4.x
npm list helmet        # Doit être 7.0.x
```

---

## ✅ Initialisation de la Base de Données

### Exécuter les migrations Prisma
```powershell
npx prisma migrate deploy
```

- [ ] Migrations déployées sans erreurs
- [ ] Tables créées dans PostgreSQL
- [ ] Schéma correspond à `schema.prisma`

### Vérifier les tables
```powershell
psql -U nanawax -d nanawax_vip -h localhost -c "\dt"
```

Devrait afficher:
- [ ] `users` table
- [ ] `clients` table
- [ ] `cartes` table
- [ ] `achats` table
- [ ] `cadeaux` table
- [ ] `journal` table
- [ ] `notifications` table
- [ ] `backup` table

---

## ✅ Démarrage du Serveur

### Lancer le serveur
```powershell
cd c:\laragon\www\backend-nanawax
npm start
```

**Devrait afficher:**
```
✅ Connecté à la base de données
👑 Admin par défaut créé
🚀 Serveur démarré sur le port 5000
```

- [ ] Pas d'erreurs au démarrage
- [ ] Message "Serveur démarré sur le port 5000"
- [ ] Process Node.js visible en arrière-plan

### Vérifier la santé du serveur
```powershell
# Dans une nouvelle terminal/PowerShell
curl http://localhost:5000/api/health

# Devrait retourner:
# {"status":"OK","timestamp":"...","version":"2.0.0"}
```

- [ ] Health check répond avec status OK
- [ ] Tous les endpoints /api/ sont accessibles

---

## ✅ Frontend et Configuration

### Fichiers Frontend
- [ ] `index.html` existe et est valide
- [ ] `config.js` est chargé dans index.html
- [ ] Toutes les dépendances JS sont présentes (Chart.js, XLSX)

### Configuration Frontend
Vérifier dans `config.js`:
- [ ] `API_URL` pointe à `http://localhost:5000/api`
- [ ] `FRONTEND_URL` est correct
- [ ] BOUTIQUES sont énumérées
- [ ] LOYALTY config est correcte

### Test du Frontend
Ouvrir dans un navigateur:
- [ ] [c:\laragon\www\index.html](file:///c:/laragon/www/index.html) se charge
- [ ] Aucune erreur dans la console (F12 → Console)
- [ ] Page de login s'affiche correctement
- [ ] Tous les éléments d'interface sont visibles

---

## ✅ Authentification

### Test de Connexion
1. Ouvrir `index.html` dans un navigateur
2. Sélectionner une boutique
3. Entrer les identifiants:
   - Email: `admin@nanawax.com`
   - Mot de passe: `admin123`
4. Cliquer "Connexion"

- [ ] Connexion réussie
- [ ] Redirection vers le dashboard
- [ ] Token JWT créé et stocké localement
- [ ] Boutique affichée correctement

### Vérifier le Token
Dans la console du navigateur (F12 → Console):
```javascript
localStorage.getItem('nanawax_token')
```

- [ ] Token existe (longue chaîne)
- [ ] Token commence par "eyJ" (format JWT)

---

## ✅ Fonctionnalités de Base

### Dashboard
- [ ] Affiche les statistiques
- [ ] Graphiques visibles
- [ ] Compteurs chargés

### Onglet Clients
- [ ] Table des clients charge
- [ ] Pagination fonctionne
- [ ] Formulaire d'ajout affiche

### Onglet Cartes
- [ ] Progression des cartes affichées
- [ ] Statut VIP correct

### Onglet Achats
- [ ] Formulaire accessible
- [ ] Calcul des cases (min 200.000 CFA)
- [ ] Historique affiche

### Onglet Cadeaux
- [ ] Liste des cadeaux charge
- [ ] Statuts affichés correctement

### Onglet Export
- [ ] Bouton Excel accessible
- [ ] Export génère un fichier

---

## ✅ Base de Données

### Contenu Initial
- [ ] Admin user créé: `admin@nanawax.com`
- [ ] Données initiales de test présentes (optionnel)

### Vérifier avec Prisma Studio
```powershell
cd c:\laragon\www\backend-nanawax
npx prisma studio
```

- [ ] Interface Prisma ouvre
- [ ] Tables visibles
- [ ] Admin user affiche
- [ ] Toutes les relations intactes

---

## ✅ Sécurité

### Configuration de Base
- [ ] `.env` ne contient pas de secrets réels (pour développement)
- [ ] `.gitignore` existe et exclut `.env`
- [ ] `node_modules` est exclu de Git
- [ ] Pas de clés sensibles en plaintext

### JWT
- [ ] `JWT_SECRET` est long et aléatoire
- [ ] `JWT_EXPIRES_IN` est configuré (7d)
- [ ] Tokens stockés dans localStorage avec httpOnly: false (acceptable en dev)

### Mot de Passe
- [ ] Admin password hashé en base (vérifié avec bcrypt)
- [ ] Hachage utilise salt rounds 12

---

## ✅ Logs et Erreurs

### Pas d'Erreurs Critiques
- [ ] Pas de "Cannot find module"
- [ ] Pas d'erreurs de connexion BD
- [ ] Pas d'erreurs CORS bloquantes
- [ ] Console du navigateur clean (warnings acceptés)

### Logs du Serveur
```powershell
# Le serveur devrait afficher:
npm start
# ✅ Connecté à la base de données
# 👑 Admin par défaut créé
# 🚀 Serveur démarré sur le port 5000
```

---

## ✅ Performance

### Temps de Réponse
- [ ] Dashboard charge en < 2 secondes
- [ ] API répond rapidement (< 500ms)
- [ ] Export Excel génère en < 5 secondes

### Pas de Fuites Mémoire
```powershell
# Vérifier que le processus Node ne prend pas trop de RAM
Get-Process node
```

- [ ] Processus node < 200 MB RAM

---

## ✅ Réseau et Domaines

### Locale
- [ ] Frontend et backend sur localhost
- [ ] Pas d'erreurs CORS
- [ ] Cookies/tokens fonctionnent

### Production (si applicable)
- [ ] FRONTEND_URL correspond au vrai domaine
- [ ] DATABASE_URL pointe à la bonne BD
- [ ] SSL/HTTPS configuré
- [ ] Firewall permet les connexions

---

## ✅ Documentation

- [ ] [START_HERE.md](./backend-nanawax/START_HERE.md) existe et est lisible
- [ ] [QUICK_START.md](./backend-nanawax/QUICK_START.md) est complet
- [ ] [README.md](./backend-nanawax/README.md) couvre tous les endpoints
- [ ] [POSTGRESQL_SETUP.md](./backend-nanawax/POSTGRESQL_SETUP.md) est détaillé
- [ ] [SETUP.html](./SETUP.html) s'affiche correctement

---

## 🎯 Étapes Suivantes après Validation

Si toutes les cases sont cochées ✅ :

1. **Créer les boutiques supplémentaires** (si nécessaire)
2. **Importer les clients existants** (si données legacy)
3. **Configurer les cadeaux** disponibles
4. **Former les utilisateurs** sur l'interface
5. **Mettre en place les sauvegardes** automatiques
6. **Déployer en production** (si prêt)

---

## ⚠️ Problèmes Courants

### ❌ "Cannot find module 'express'"
```powershell
npm install
```

### ❌ "connect ECONNREFUSED 127.0.0.1:5432"
PostgreSQL n'est pas en cours d'exécution
```powershell
Restart-Service PostgreSQL-x64-15
```

### ❌ "EADDRINUSE :::5000"
Port 5000 en utilisation
```powershell
# Changer le port dans .env à 5001
# Ou trouvez ce qui utilise 5000:
netstat -ano | findstr :5000
```

### ❌ "Uncaught SyntaxError" au frontend
Vérifier la console (F12 → Console)
- Vérifier les chemins des fichiers
- Vérifier que config.js charge avant index.html
- Vérifier la syntaxe HTML

---

## 📊 Résumé de Santé

Après vérification, vous devriez avoir:

- ✅ **Backend**: Express.js lancé sur port 5000
- ✅ **Frontend**: HTML chargeable et responsive
- ✅ **Database**: PostgreSQL avec tables créées
- ✅ **Auth**: Connexion fonctionnelle
- ✅ **API**: Endpoints accessibles
- ✅ **UI**: Interface complète et intuitive
- ✅ **Docs**: Documentation claire et disponible

---

## 🎉 Félicitations !

Si vous avez coché toutes les cases, **Nanawax VIP est prêt à l'emploi** ! 🚀

**Bon travail et succès avec votre système VIP !**

---

_Généré pour Nanawax VIP v2.0.0_  
_Dernière mise à jour: 2024_
