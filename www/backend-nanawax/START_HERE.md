# 🎉 NANAWAX VIP - APPLICATION COMPLÈTE

## 📁 Structure du Projet

```
c:\laragon\www\
├── index.html                      # Frontend application
├── config.js                        # Configuration frontend
├── SETUP.html                       # Page de setup et guide
│
└── backend-nanawax/                # Dossier backend
    ├── server.js                   # Serveur principal
    ├── package.json                # Dépendances Node.js
    ├── .env                        # Variables d'environnement
    ├── .gitignore                  # Git ignore
    │
    ├── start.bat                   # Script démarrage simple
    ├── start-complete.bat          # Script démarrage complet avec vérifications
    ├── setup-postgresql.ps1        # Configuration automatique PostgreSQL
    │
    ├── README.md                   # Documentation complète
    ├── QUICK_START.md              # Guide de démarrage rapide
    ├── POSTGRESQL_SETUP.md         # Guide PostgreSQL détaillé
    │
    ├── prisma/
    │   ├── schema.prisma           # Schéma de la base de données
    │   └── init.sql                # Script d'initialisation PostgreSQL
    │
    └── src/
        ├── middleware/
        │   └── auth.js             # Authentification & permissions
        └── routes/
            └── auth.js             # Routes d'authentification
```

---

## 🚀 DÉMARRAGE COMPLET (Première Fois)

### Prérequis
- ✅ Node.js 18+ installé
- ✅ npm 8+ installé  
- ✅ PostgreSQL 12+ installé
- ✅ PowerShell avec droits administrateur

### Étapes

**1️⃣ Ouvrez PowerShell en tant qu'administrateur**

**2️⃣ Allez au dossier backend**
```powershell
cd c:\laragon\www\backend-nanawax
```

**3️⃣ Configurez PostgreSQL**
```powershell
powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1
```

**4️⃣ Installez les dépendances**
```powershell
npm install
```

**5️⃣ Initialisez la base de données**
```powershell
npx prisma migrate deploy
```

**6️⃣ Démarrez le serveur**
```powershell
npm start
```

### ✅ C'est bon !

Le serveur est maintenant actif:
- 🔗 **API Backend**: http://localhost:5000
- 🎨 **Frontend**: Ouvrez [c:\laragon\www\index.html](index.html) dans votre navigateur
- 📊 **Health Check**: http://localhost:5000/api/health
- 🗄️ **Base de données GUI**: `npx prisma studio`

---

## 🔐 Connexion par Défaut

```
Email: admin@nanawax.com
Mot de passe: admin123
Boutique: Sélectionnez une boutique au login
```

---

## 📱 UTILISATION QUOTIDIENNE

### Démarrer l'application (après la première fois)

**Option 1: Avec script batch** (Recommandé pour Windows)
```powershell
cd c:\laragon\www\backend-nanawax
.\start-complete.bat
```

**Option 2: Avec npm**
```powershell
cd c:\laragon\www\backend-nanawax
npm start
```

**Option 3: Mode développement** (avec reload automatique)
```powershell
cd c:\laragon\www\backend-nanawax
npm run dev
```

### Accéder au frontend
1. Ouvrez un navigateur web
2. Allez sur: [file:///c:/laragon/www/index.html](file:///c:/laragon/www/index.html)
3. Ou consultez le serveur setup: [file:///c:/laragon/www/SETUP.html](file:///c:/laragon/www/SETUP.html)

---

## 🛠️ COMMANDES DISPONIBLES

### Backend

```bash
npm start                           # Démarrer le serveur (production)
npm run dev                         # Mode développement avec reload auto
npm run prisma:generate            # Générer le client Prisma
npm run prisma:migrate             # Créer une nouvelle migration
npm run prisma:deploy              # Déployer les migrations
npm run prisma:reset               # Réinitialiser la BD (⚠️ efface les données)
npm run prisma:studio              # Ouvrir GUI de la base de données
npm install                         # Installer/réinstaller les packages
```

### PostgreSQL

```powershell
# Se connecter à la base de données
psql -U nanawax -d nanawax_vip -h localhost

# Commandes utiles dans psql:
\l                                 # Lister les bases de données
\du                                # Lister les utilisateurs
\dt                                # Lister les tables
\d table_name                      # Voir la structure d'une table
\q                                 # Quitter
```

---

## 📊 ENDPOINTS API PRINCIPAUX

### Authentification
- `POST /api/auth/login` - Connexion
- `POST /api/auth/logout` - Déconnexion  
- `GET /api/auth/verify` - Vérifier le token
- `POST /api/auth/change-password` - Changer le mot de passe

### Clients
- `GET /api/clients` - Liste des clients
- `POST /api/clients` - Créer un client
- `GET /api/clients/:id` - Détails d'un client
- `PUT /api/clients/:id` - Mettre à jour un client

### Cartes de Fidélité
- `GET /api/cartes/:clientId` - Cartes du client
- `POST /api/cartes/:clientId/case` - Ajouter une case

### Achats
- `POST /api/achats` - Enregistrer un achat
- `GET /api/achats/client/:clientId` - Historique des achats

### Cadeaux
- `GET /api/cadeaux` - Liste des cadeaux
- `POST /api/cadeaux/:id/remise` - Marquer comme remis

### Santé
- `GET /api/health` - État du serveur

---

## ⚠️ DÉPANNAGE

### Le serveur ne démarre pas

**Erreur: "Cannot find module 'express'"**
```powershell
npm install
```

**Erreur: "EADDRINUSE :::5000"** (Port déjà utilisé)
```powershell
# Modifiez le port dans .env
# PORT=5001

# Ou trouvez ce qui utilise le port:
netstat -ano | findstr :5000
```

### PostgreSQL ne se connecte pas

**Erreur: "connect ECONNREFUSED 127.0.0.1:5432"**
```powershell
# Vérifiez que PostgreSQL est en cours d'exécution
Get-Service -Name PostgreSQL* | Start-Service

# Ou redémarrez le service
Restart-Service PostgreSQL-x64-15
```

**Erreur: "password authentication failed"**
- Vérifiez les identifiants dans `.env`
- Exécutez setup-postgresql.ps1 de nouveau

### Base de données vide ou cassée

```powershell
# Réinitialiser complètement (⚠️ efface TOUTES les données)
npx prisma migrate reset --force
```

### Frontend ne se charge pas

- Assurez-vous que le backend est démarré (npm start)
- Ouvrez la console du navigateur (F12) pour voir les erreurs
- Vérifiez que l'URL API dans config.js est correcte

---

## 🔒 SÉCURITÉ

### À faire avant production

1. **Changer le JWT_SECRET dans .env**
   ```env
   JWT_SECRET=votre_clé_secrète_très_longue_et_complexe
   ```

2. **Changer les mots de passe par défaut**
   - Admin: changer admin123
   - nanawax (PostgreSQL): changer nanawax123

3. **Configuration CORS**
   Modifiez FRONTEND_URL dans .env avec votre domaine réel

4. **Mode production**
   ```env
   NODE_ENV=production
   ```

---

## 📈 GESTION DE LA BASE DE DONNÉES

### Voir les données
```powershell
npx prisma studio
```
Une interface graphique s'ouvre pour consulter/éditer les données

### Sauvegarde
```powershell
# Créer un backup
pg_dump -U nanawax nanawax_vip > backup.sql

# Restaurer à partir d'un backup
psql -U nanawax nanawax_vip < backup.sql
```

---

## 🎨 PERSONNALISATION

### Ajouter une boutique
Éditez `config.js`:
```javascript
BOUTIQUES: [
    // ... existantes
    { id: 7, name: 'Nouvelle Boutique', code: 'NB' }
]
```

### Modifier les règles VIP
Éditez dans `config.js`:
```javascript
LOYALTY: {
    CASES_PER_CARD: 10,          // Nombre de cases par carte
    MIN_PURCHASE_FOR_CASE: 200000, // Montant minimum pour une case
    CURRENCY: 'CFA'
}
```

### Changer le thème
Éditez les couleurs dans `config.js` ou directement dans les fichiers CSS

---

## 📚 DOCUMENTATION

- **[QUICK_START.md](./backend-nanawax/QUICK_START.md)** - Démarrage rapide
- **[README.md](./backend-nanawax/README.md)** - Documentation complète
- **[POSTGRESQL_SETUP.md](./backend-nanawax/POSTGRESQL_SETUP.md)** - Configuration PostgreSQL
- **[SETUP.html](./SETUP.html)** - Guide interactif

---

## 📞 SUPPORT

En cas de problème:

1. **Vérifiez les logs du serveur** - Le message d'erreur y est souvent
2. **Consultez la section Dépannage** ci-dessus
3. **Réinstaller les packages**: `npm install`
4. **Réinitialiser la BD**: `npx prisma migrate reset`

---

## 📝 NOTES DE VERSION

### v2.0.0 (Current)
- ✅ Express.js backend complet
- ✅ Authentification JWT
- ✅ PostgreSQL avec Prisma ORM
- ✅ Frontend HTML/CSS/JS
- ✅ Système de fidélité complet
- ✅ Gestion clients et cadeaux
- ✅ Exports Excel
- ✅ Dashboard avec statistiques

### Futures améliorations
- 📱 Application mobile
- 📊 Rapports avancés
- 🔔 Notifications en temps réel
- 🎯 Analytics personnalisées
- 🌐 Multilangue

---

## 🎯 OBJECTIF ATTEINT ✅

**Nanawax VIP est maintenant en production et prêt à être utilisé !**

### Prochaines étapes recommandées:
1. Tester la connexion avec les identifiants par défaut
2. Créer des boutiques supplémentaires
3. Ajouter les premiers clients
4. Tester les achetis et le système de fidélité
5. Vérifier les exports Excel
6. Paramétrer la sauvegarde automatique
7. Former les utilisateurs

---

**✨ Bon développement et succès avec Nanawax VIP !**
