# [palette] NANAWAX VIP - Management System Complet

> **Système de gestion VIP et de fidélité pour Nanawax**  
> Plateforme web complète avec backend Node.js et frontend HTML5  
> Version: 2.0.0 | Production Ready [done_all]

---

## [star] Vue d'Ensemble

Nanawax VIP est une application complète de gestion de clients VIP et de programme de fidélité. Elle permet:

- [people] **Gestion des clients VIP** avec profils détaillés
- [card_giftcard] **Système de cartes de fidélité** (cartes à 10 cases)
- [credit_card] **Suivi des achats** avec calcul automatique des cases
- [celebration] **Gestion des cadeaux** et attribution aux clients
- [bar_chart] **Dashboard avec statistiques** et analytics
- [download] **Export de données** en Excel
- [lock] **Authentification et permissions** par rôle
- [store] **Gestion multi-boutiques**

---

## [package] Ce qui est Inclus

### Backend (Dossier: `backend-nanawax/`)
- **Express.js** - Serveur Node.js
- **Prisma** - ORM pour PostgreSQL
- **JWT** - Authentification sécurisée
- **bcryptjs** - Hachage de mots de passe
- **Helmet** - Sécurité HTTP
- **CORS** - Gestion des requêtes inter-domaines
- **Express Rate Limit** - Protection contre les abus

### Frontend (Fichier: `index.html`)
- **HTML5** - Structure de l'application
- **CSS3** - Styling responsive
- **JavaScript Vanilla** - Sans dépendances externes
- **Chart.js** - Graphiques et visualisations
- **XLSX** - Export Excel

### Database
- **PostgreSQL** 12+ - Base de données relationnelle
- **Prisma Schema** - Modèle de données complet

---

## [bolt] Démarrage Rapide (5 minutes)

### [one] Configuration PostgreSQL (Une seule fois)

```powershell
cd c:\laragon\www\backend-nanawax
powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1
```

### [two] Installation des dépendances

```powershell
npm install
```

### [three] Initialisation de la base de données

```powershell
npx prisma migrate deploy
```

### [four] Démarrage du serveur

```powershell
npm start
```

### [five] Accès à l'application

- **Frontend**: [c:\laragon\www\index.html](./index.html)
- **API**: http://localhost:5000/api
- **Health Check**: http://localhost:5000/api/health

---

## [lock] Identifiants par Défaut

```
Email: admin@nanawax.com
Mot de passe: admin123
```

[warning] À changer après la première connexion !

---

## [folder] Structure du Projet

```
c:\laragon\www/
│
├── 📄 index.html                  # Frontend application
├── 📄 config.js                    # Configuration frontend
├── 📄 SETUP.html                   # Guide de setup interactif
├── 📄 README.md                    # Ce fichier
│
└── 📁 backend-nanawax/            # Serveur Node.js
    │
    ├── 📄 server.js                # Point d'entrée principal
    ├── 📄 package.json             # Dépendances Node.js
    ├── 📄 .env                     # Variables d'environnement
    ├── 📄 .gitignore               # Fichiers à ignorer dans Git
    │
    ├── [rocket] Scripts de démarrage
    ├── 📄 start.bat                # Démarrage simple
    ├── 📄 start-complete.bat       # Démarrage avec vérifications
    ├── 📄 setup-postgresql.ps1     # Configuration PostgreSQL
    │
    ├── [library] Documentation
    ├── 📄 START_HERE.md            # ⭐ Commencez ici !
    ├── 📄 QUICK_START.md           # Démarrage rapide
    ├── 📄 README.md                # Documentation backend complète
    ├── 📄 POSTGRESQL_SETUP.md      # Guide PostgreSQL détaillé
    │
    ├── [storage] Database
    ├── 📁 prisma/
    │   ├── schema.prisma           # Modèle de données
    │   └── init.sql                # Script d'initialisation
    │
    ├── [build] Code source
    └── 📁 src/
        ├── 📁 middleware/
        │   └── auth.js             # Authentification & permissions
        └── 📁 routes/
            └── auth.js             # Routes d'authentification
```

---

## [target] Fonctionnalités Principales

### 1. **Authentification & Sécurité**
- Connexion sécurisée avec JWT
- Gestion des sessions
- Contrôle d'accès par rôle (ADMIN, MANAGER, BOUTIQUE, VENDEUR)
- Hachage des mots de passe avec bcryptjs

### 2. **Gestion des Clients**
- Base de données client complète
- Profil VIP personnalisé
- Historique des achats
- Statut de fidélité
- Boutique d'affectation

### 3. **Cartes de Fidélité**
- Cartes à 10 cases
- Accumulation automatique des cases
- Progression visible en temps réel
- Complétions et récompenses

### 4. **Gestion des Achats**
- Enregistrement des achats (min. 200.000 CFA = 1 case)
- Historique complet
- Calcul automatique de l'éligibilité
- Suivi par client

### 5. **Gestion des Cadeaux**
- Attribution de cadeaux aux clients VIP
- Suivi du statut (En attente, Remis, Annulé)
- Historique des distributions
- Alertes et notifications

### 6. **Dashboard & Analytics**
- Statistiques clés (clients totaux, achats, cartes complétées)
- Graphiques interactifs
- Filtrage par boutique
- Tendances de vente

### 7. **Exports & Reports**
- Export Excel des clients
- Export des achats
- Export des cadeaux
- Rapports personnalisables

### 8. **Multi-Boutiques**
- Gestion de 6 boutiques
- Permissions par boutique
- Responsables assignés
- Suivi centralisé

---

## [build] Commandes Disponibles

### Serveur

```bash
npm start                   # Démarrer en production
npm run dev                 # Mode développement (reload auto)
npm run prisma:generate    # Générer Prisma client
npm run prisma:migrate     # Créer une migration
npm run prisma:deploy      # Déployer les migrations
npm run prisma:reset       # Réinitialiser la BD ([warning])
npm run prisma:studio      # Ouvrir Prisma Studio
npm install                # Installer les packages
```

### PostgreSQL

```powershell
# Se connecter à la base de données
psql -U nanawax -d nanawax_vip -h localhost

# Commandes utiles
\l                         # Lister les bases
\du                        # Lister les utilisateurs
\dt                        # Lister les tables
\d table_name             # Voir structure table
\q                        # Quitter
```

---

## [bar_chart] API Endpoints

### Authentification
| Méthode | Route | Description |
|---------|-------|-------------|
| POST | `/api/auth/login` | Connexion |
| POST | `/api/auth/logout` | Déconnexion |
| GET | `/api/auth/verify` | Vérifier le token |
| POST | `/api/auth/change-password` | Changer mot de passe |

### Clients
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/api/clients` | Liste des clients |
| POST | `/api/clients` | Créer un client |
| GET | `/api/clients/:id` | Détails client |
| PUT | `/api/clients/:id` | Mettre à jour |

### Cartes
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/api/cartes/:clientId` | Cartes du client |
| POST | `/api/cartes/:clientId/case` | Ajouter une case |

### Achats
| Méthode | Route | Description |
|---------|-------|-------------|
| POST | `/api/achats` | Enregistrer achat |
| GET | `/api/achats/client/:clientId` | Historique |

### Cadeaux
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/api/cadeaux` | Liste des cadeaux |
| POST | `/api/cadeaux/:id/remise` | Marquer remis |

### Santé
| Méthode | Route | Description |
|---------|-------|-------------|
| GET | `/api/health` | État du serveur |

---

## [settings] Variables d'Environnement (.env)

```env
# [build] Serveur
PORT=5000
NODE_ENV=development

# [storage] Base de données
DATABASE_URL="postgresql://nanawax:nanawax123@localhost:5432/nanawax_vip"

# [lock] JWT
JWT_SECRET=your_secret_jwt_key_change_in_production
JWT_EXPIRES_IN=7d

# [public] Frontend
FRONTEND_URL=http://localhost:3000

# [email] Email (optionnel)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password

# [edit] Logging
LOG_LEVEL=info
```

---

## [storage] Schéma de Base de Données

### Tables Principales

**users**
- Utilisateurs du système avec authentification

**clients**
- Informations des clients VIP

**cartes**
- Cartes de fidélité (10 cases)

**achats**
- Historique des achats et accumulation

**cadeaux**
- Cadeaux proposés et leur distribution

**journal**
- Logs de toutes les opérations

**notifications**
- Notifications système

**backup**
- Sauvegardes de la base de données

---

## 🔒 Rôles et Permissions

### ADMIN
- Accès complet à tout le système
- Gestion des utilisateurs
- Configuration système
- Rapports avancés

### MANAGER
- Gestion des clients et cadeaux
- Supervision des boutiques
- Rapports et exports
- Gestion des stocks cadeaux

### BOUTIQUE (Responsable)
- Gestion des clients de la boutique
- Enregistrement des achats
- Gestion des cartes locales
- Suivi des ventes

### VENDEUR
- Enregistrement des achats
- Suivi des clients
- Consultation des cartes
- Support client

---

## [library] Documentation Disponible

| Fichier | Description |
|---------|-------------|
| **START_HERE.md** | ⭐ Commencez par celui-ci ! |
| **QUICK_START.md** | Démarrage en 5 minutes |
| **README.md** | Documentation complète |
| **POSTGRESQL_SETUP.md** | Configuration base de données |
| **SETUP.html** | Guide interactif |
| **config.js** | Configuration frontend |

---

## [warning] Dépannage Rapide

### Le serveur ne démarre pas

```powershell
# Installer les dépendances
npm install

# Vérifier Node.js
node --version

# Vérifier npm
npm --version
```

### PostgreSQL ne se connecte pas

```powershell
# Redémarrer PostgreSQL
Restart-Service PostgreSQL-x64-15

# Vérifier la connexion
psql -U nanawax -d nanawax_vip -h localhost
```

### Port 5000 en utilisation

```powershell
# Changer le port dans .env
PORT=5001

# Ou trouver ce qui utilise le port
netstat -ano | findstr :5000
```

### Base de données cassée

```powershell
# Réinitialiser (⚠️ efface les données)
npx prisma migrate reset --force
```

---

## 🔄 Mise à Jour et Maintenance

### Sauvegarder la base de données

```powershell
pg_dump -U nanawax nanawax_vip > backup_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').sql
```

### Restaurer à partir d'une sauvegarde

```powershell
psql -U nanawax nanawax_vip < backup.sql
```

### Mettre à jour les packages

```powershell
npm update
npm install
```

---

## [rocket] Déploiement en Production

### Avant de déployer

1. **Changer le JWT_SECRET**
   ```env
   JWT_SECRET=une_clé_vraiment_longue_et_sécurisée_12345...
   ```

2. **Changer le MODE**
   ```env
   NODE_ENV=production
   ```

3. **Changer les identifiants PostgreSQL** (pas admin/admin123)

4. **Configurer CORS correctement**
   ```env
   FRONTEND_URL=https://votre-domaine.com
   ```

5. **Mettre en place des sauvegardes** automatiques

6. **Configurer un certificat SSL** pour HTTPS

### Serveurs recommandés
- **Heroku** - Facile et sans configuration
- **Digital Ocean** - Abordable et flexible
- **AWS** - Scalabilité illimitée
- **Vercel/Netlify** - Pour le frontend uniquement

---

## [bar_chart] Performance et Optimisation

### Optimisations actuelles
- [done_all] Pagination des requêtes
- [done_all] Indexation des bases de données
- [done_all] Caching JWT
- [done_all] Compression Gzip
- [done_all] Rate limiting

### À optimiser
- [cached] Ajouter caching Redis
- [cached] Implémenter GraphQL
- [cached] Ajouter des webhooks
- [cached] Améliorer les rapports
- [cached] Ajouter des notifications temps-réel

---

## [link] Technologie Stack

### Backend
- **Node.js** 18+
- **Express** 4.18+
- **Prisma** 5.0+
- **PostgreSQL** 12+
- **JWT** pour authentification
- **bcryptjs** pour sécurité

### Frontend
- **HTML5**
- **CSS3**
- **JavaScript ES6+**
- **Chart.js** pour graphiques
- **XLSX** pour Excel

### DevOps
- **Git** pour versioning
- **npm** pour packages
- **PowerShell** pour scripts
- **Batch files** pour automation

---

## [edit] Notes de Version

### v2.0.0 (Actuelle)
- [done_all] Backend Express.js complet
- [done_all] Frontend HTML5 moderne
- [done_all] Authentification JWT
- [done_all] PostgreSQL avec Prisma
- [done_all] Système de fidélité complet
- [done_all] Multi-boutiques
- [done_all] Export Excel
- [done_all] Dashboard analytics
- [done_all] API RESTful complète

### v1.0.0 (Ancien)
- [close] Structure basique
- [close] Fonctionnalités limitées

---

## [phone] Support et Aide

### Problèmes courants
Voir section **[Dépannage Rapide](#-dépannage-rapide)** ci-dessus

### Consulter la documentation
- [START_HERE.md](./backend-nanawax/START_HERE.md)
- [QUICK_START.md](./backend-nanawax/QUICK_START.md)
- [README.md](./backend-nanawax/README.md)
- [POSTGRESQL_SETUP.md](./backend-nanawax/POSTGRESQL_SETUP.md)

### Contact
📧 support@nanawax.com  
🌐 www.nanawax.com

---

## [description] Licence et Propriété

**© 2024 Nanawax VIP Management System**
- Système propriétaire exclusif à Nanawax
- Usage interne uniquement
- Non autorisé pour redistribution

---

## [star] Remerciements

Merci à:
- **Node.js** & **Express** pour le backend
- **Prisma** pour l'ORM
- **PostgreSQL** pour la base de données
- Tous les contributeurs open-source

---

## [celebration] C'est Prêt !

**Nanawax VIP est entièrement configuré et prêt à l'emploi !**

### Prochaines étapes:
1. [done_all] Lancer le serveur: `npm start`
2. [done_all] Accéder au frontend: [index.html](./index.html)
3. [done_all] Se connecter avec admin@nanawax.com / admin123
4. [done_all] Créer les premiers clients
5. [done_all] Tester le système de fidélité
6. [done_all] Former les utilisateurs

---

**[crown] Bon développement avec Nanawax VIP !**  
*Version 2.0.0 - Production Ready [done_all]*
