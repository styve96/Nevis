# [rocket] Guide de Démarrage Rapide - Nanawax VIP

## [bolt] En 5 minutes

### [one] Ouvrez PowerShell en tant qu'administrateur

### [two] Configurez PostgreSQL (une seule fois)

```powershell
cd c:\laragon\www\backend-nanawax
powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1
```

### [three] Installez les dépendances

```powershell
npm install
```

### [four] Initialisez la base de données

```powershell
npx prisma migrate deploy
```

### [five] Démarrez le serveur

```powershell
npm start
```

[done_all] **Terminé !** Le serveur est lancé sur `http://localhost:5000`

---

## [lock] Se connecter au frontend

1. Ouvrez `http://localhost:3000` (ou selon votre configuration)
2. Sélectionnez une boutique
3. Connectez-vous avec:
   - **Email**: `admin@nanawax.com`
   - **Mot de passe**: `admin123`

---

## [bar_chart] Accès à la base de données

```powershell
# Voir la base de données en GUI
npx prisma studio

# Ou en ligne de commande
psql -U nanawax -d nanawax_vip -h localhost
```

---

## [lightbulb] Commandes disponibles

```bash
npm start              # Lancer le serveur
npm run dev           # Lancer en mode développement (reload auto)
npx prisma studio    # Ouvrir l'interface GUI de la base de données
npx prisma migrate dev --name <name>  # Créer une migration
npx prisma migrate reset --force      # Réinitialiser la base de données
```

---

## [close] Problèmes courants

### PostgreSQL refuse la connexion
```powershell
# Redémarrer PostgreSQL
Restart-Service PostgreSQL-x64-15

# Ou manuellement dans Services (services.msc)
```

### Port 5000 déjà utilisé
Modifiez le port dans `.env`:
```env
PORT=5001
```

### Module introuvable
```powershell
rm -r node_modules
npm install
```

### Erreur de migration
```powershell
# Réinitialiser complètement (attention: efface les données)
npx prisma migrate reset --force
```

---

## [library] Documentation complète

- [README.md](./README.md) - Configuration détaillée
- [POSTGRESQL_SETUP.md](./POSTGRESQL_SETUP.md) - Guide PostgreSQL
- [src/routes/auth.js](./src/routes/auth.js) - Routes d'authentification
- [prisma/schema.prisma](./prisma/schema.prisma) - Schéma de la base de données

---

## [target] Architecture

```
Backend (Express.js)
│
├── [lock] Authentication (JWT)
├── [people] Clients Management
├── [card_giftcard] Loyalty Cards System
├── [credit_card] Purchases Tracking
├── [celebration] Gifts Management
└── [bar_chart] Analytics & Exports

↓

Database (PostgreSQL)
│
├── Users
├── Clients
├── Cartes (Loyalty Cards)
├── Achats (Purchases)
├── Cadeaux (Gifts)
├── Journal (Activity Logs)
├── Notifications
└── Backup

↓

Frontend (HTML/CSS/JS)
│
├── [key] Login
├── [bar_chart] Dashboard
├── [people] Clients
├── [card_giftcard] Cartes
├── [credit_card] Achats
├── [celebration] Cadeaux
└── [download] Export Excel
```

---

## [search] Endpoints principaux

| Méthode | Route | Description |
|---------|-------|-------------|
| POST | `/api/auth/login` | Connexion utilisateur |
| POST | `/api/auth/logout` | Déconnexion |
| GET | `/api/auth/verify` | Vérifier le token |
| GET | `/api/clients` | Liste des clients |
| POST | `/api/clients` | Créer un client |
| GET | `/api/cartes/:clientId` | Cartes du client |
| POST | `/api/achats` | Enregistrer un achat |
| GET | `/api/cadeaux` | Liste des cadeaux |
| POST | `/api/cadeaux/:id/remise` | Marquer cadeau comme remis |
| GET | `/api/health` | Vérifier l'état du serveur |

---

## [alternate_email] Variables d'environnement (.env)

```env
# Serveur
PORT=5000
NODE_ENV=development

# Base de données
DATABASE_URL="postgresql://nanawax:nanawax123@localhost:5432/nanawax_vip"

# JWT
JWT_SECRET=your_secret_jwt_key_change_in_production
JWT_EXPIRES_IN=7d

# Frontend
FRONTEND_URL=http://localhost:3000

# Options avancées
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
LOG_LEVEL=info
```

---

## [help] Support

En cas de problème:
1. Vérifiez que PostgreSQL est en cours d'exécution
2. Vérifiez les identifiants dans `.env`
3. Consultez les logs du serveur
4. Exécutez `npm run prisma:reset` pour réinitialiser la base

---

**[star] Bon développement avec Nanawax VIP !**
