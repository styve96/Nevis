# [palette] Nanawax VIP - Guide d'Installation et Démarrage

## [list] Prérequis

- **Node.js** v18+ ([Télécharger](https://nodejs.org/))
- **PostgreSQL** v12+ ([Télécharger](https://www.postgresql.org/download/))
- **npm** ou **yarn**

## [rocket] Étapes de Démarrage

### [one] Installation des Dépendances

```bash
cd backend-nanawax
npm install
```

Cela installera :
- [done_all] Express.js (serveur web)
- [done_all] Prisma (ORM base de données)
- [done_all] JWT (authentification)
- [done_all] bcryptjs (hachage des mots de passe)
- [done_all] CORS, Helmet, Rate Limit (sécurité)

### [two] Configuration de la Base de Données

#### Créer une base de données PostgreSQL :

**Sur Windows (avec PostgreSQL)** :
```powershell
# Connectez-vous à PostgreSQL
psql -U postgres

# Créer l'utilisateur
CREATE USER nanawax WITH PASSWORD 'nanawax123';

# Créer la base de données
CREATE DATABASE nanawax_vip OWNER nanawax;

# Donner les permissions
GRANT ALL PRIVILEGES ON DATABASE nanawax_vip TO nanawax;

# Quitter
\q
```

**Ou avec pgAdmin** (interface graphique) :
1. Créer un nouvel utilisateur : `nanawax` / `nanawax123`
2. Créer une base de données : `nanawax_vip`

#### Initialiser le schéma Prisma :

```bash
# Générer le client Prisma
npx prisma generate

# Migrer la base de données (crée les tables)
npx prisma migrate deploy

# (Optionnel) Visualiser et gérer la base de données
npx prisma studio
```

### [three] Variables d'Environnement

Le fichier `.env` est déjà configuré avec :

```env
PORT=5000
NODE_ENV=development
FRONTEND_URL=http://localhost:3000
DATABASE_URL="postgresql://nanawax:nanawax123@localhost:5432/nanawax_vip"
JWT_SECRET="votre_secret_jwt_tres_long_et_complexe_changez_le_en_production_!@#$%"
JWT_EXPIRES_IN="7d"
```

**[warning] Important** : En production, changez `JWT_SECRET` par une clé complexe et aléatoire.

### [four] Lancer le Serveur

```bash
npm start
```

Vous devriez voir :
```
[done_all] Connecté à la base de données
[crown] Admin par défaut créé (username: admin, password: admin123)

[rocket] Serveur démarré sur le port 5000
[bar_chart] Interface Frontend: http://localhost:3000
[link] API Base URL: http://localhost:5000/api
[favorite] Health Check: http://localhost:5000/api/health
```

### [five] Accéder à l'Application

**Frontend** : http://localhost:3000 (ou votre port)

**Identifiants de test** :
- [person] Admin : `admin` / `admin123`
- [people] Manager : `manager` / `manager123`
- [shopping_bag] Vendeur : `vendeur` / `vendeur123` (boutique: Cotonou)

## 🔗 Endpoints API Disponibles

### Authentification
```
POST   /api/auth/login              - Connexion
POST   /api/auth/logout             - Déconnexion
GET    /api/auth/verify             - Vérifier le token
POST   /api/auth/change-password    - Changer le mot de passe
```

### Clients
```
GET    /api/clients                 - Récupérer tous les clients
POST   /api/clients                 - Créer un client
PUT    /api/clients/:id             - Modifier un client
DELETE /api/clients/:id             - Supprimer un client
GET    /api/clients/:id/stats       - Statistiques d'un client
```

### Cartes de Fidélité
```
GET    /api/cartes                  - Récupérer toutes les cartes
POST   /api/cartes/:id/cocher-case  - Cocher une case
```

### Achats
```
GET    /api/achats                  - Récupérer tous les achats
POST   /api/achats                  - Créer un achat
GET    /api/achats/stats            - Statistiques des achats
```

### Cadeaux
```
GET    /api/cadeaux                 - Récupérer tous les cadeaux
POST   /api/cadeaux                 - Attribuer un cadeau
PUT    /api/cadeaux/:id/statut      - Changer le statut
```

### Dashboard
```
GET    /api/dashboard/stats         - Statistiques générales
GET    /api/dashboard/evolution     - Évolution sur 6 mois
```

### Santé
```
GET    /api/health                  - Vérifier l'état du serveur
```

## [build] Mode Développement

Pour un développement avec rechargement automatique :

```bash
npm run dev
```

(Nécessite `nodemon` - déjà installé via npm install)

## [folder] Structure du Projet

```
backend-nanawax/
├── server.js                 # Point d'entrée principal
├── package.json             # Dépendances
├── .env                     # Variables d'environnement
├── .gitignore              # Fichiers à ignorer git
├── prisma/
│   ├── schema.prisma       # Schéma base de données
│   └── migrations/         # Historique des migrations
└── src/
    ├── middleware/
    │   └── auth.js         # Authentification & permissions
    └── routes/
        └── auth.js         # Routes d'authentification
```

## [warning] Dépannage

### Erreur : "Cannot find module '@prisma/client'"
```bash
npm install @prisma/client prisma
npx prisma generate
```

### Erreur : "Connection refused" (Base de données)
- Vérifier que PostgreSQL est démarré
- Vérifier `DATABASE_URL` dans `.env`
- Créer la base de données si elle n'existe pas

### Erreur : "Port 5000 already in use"
Changer le port dans `.env` :
```env
PORT=5001
```

### CORS Error (depuis le frontend)
Vérifier `FRONTEND_URL` dans `.env` correspond à l'URL du frontend

## [lock] Sécurité en Production

1. **Changez JWT_SECRET** par une clé complexe
2. **Utilisez HTTPS** (certificats SSL)
3. **Changez les mots de passe par défaut**
4. **Mettez à jour NODE_ENV** en `production`
5. **Configurez une base de données sécurisée**
6. **Limitez les requêtes** avec rate limiting
7. **Sauvegardez régulièrement** la base de données

## [phone] Support

Pour toute question ou erreur, vérifiez :
- Les logs du serveur (console)
- Le fichier `.env`
- La connexion à la base de données
- Les ports utilisés

Bonne chance ! [rocket]
