# 🗄️ Configuration PostgreSQL pour Nanawax VIP

## 📋 Prérequis

- PostgreSQL 12+ installé
- pgAdmin 4 (optionnel mais recommandé) OU
- Accès en ligne de commande à PostgreSQL

---

## 🔧 Méthode 1 : Avec pgAdmin (Interface Graphique)

### Étape 1 : Ouvrir pgAdmin
1. Lancez **pgAdmin 4**
2. Connectez-vous avec votre mot de passe administrateur

### Étape 2 : Créer un nouvel utilisateur
1. Allez dans **Login/Group Roles** (dans le menu de gauche)
2. Clic droit → **Create** → **Login/Group Role**
3. Remplissez :
   - **Name**: `nanawax`
   - **Password**: `nanawax123` (confirmez)
4. Onglet **Privileges** : Cochez **Can login**
5. Cliquez **Save**

### Étape 3 : Créer la base de données
1. Allez dans **Databases**
2. Clic droit → **Create** → **Database**
3. Remplissez :
   - **Database name**: `nanawax_vip`
   - **Owner**: `nanawax` (dropdown)
4. Cliquez **Save**

### ✅ Terminé !
Votre base de données est prête avec :
- 👤 Utilisateur : `nanawax`
- 🔐 Mot de passe : `nanawax123`
- 🗄️ Base de données : `nanawax_vip`

---

## 🔧 Méthode 2 : Avec PowerShell (Ligne de Commande)

### Étape 1 : Ouvrir PowerShell en tant qu'administrateur

### Étape 2 : Exécuter le script SQL

```powershell
# Accédez au dossier du projet
cd c:\laragon\www\backend-nanawax

# Connectez-vous à PostgreSQL
psql -U postgres -h localhost

# Vous devriez voir le prompt : postgres=#
```

### Étape 3 : Exécuter les commandes SQL

Copiez-collez ces commandes une par une :

```sql
-- Créer l'utilisateur
CREATE USER nanawax WITH PASSWORD 'nanawax123';

-- Créer la base de données
CREATE DATABASE nanawax_vip OWNER nanawax;

-- Donner les permissions
GRANT ALL PRIVILEGES ON DATABASE nanawax_vip TO nanawax;
GRANT USAGE ON SCHEMA public TO nanawax_vip;
GRANT CREATE ON SCHEMA public TO nanawax;

-- Quitter
\q
```

---

## 🔧 Méthode 3 : Avec le script fourni

```powershell
# Accédez au dossier PostgreSQL
cd "C:\Program Files\PostgreSQL\15\bin"

# Exécutez le script
psql -U postgres -f "c:\laragon\www\backend-nanawax\prisma\init.sql"
```

---

## ✅ Vérifier la Configuration

### Tester la connexion :

```powershell
psql -U nanawax -d nanawax_vip -h localhost

# Vous devriez voir : nanawax_vip=>
# Si oui, c'est bon ! Tapez \q pour quitter
```

---

## 📝 Configuration dans Node.js

Le fichier `.env` est déjà configuré avec :

```env
DATABASE_URL="postgresql://nanawax:nanawax123@localhost:5432/nanawax_vip"
```

### Initialiser les tables avec Prisma :

```bash
cd c:\laragon\www\backend-nanawax
npx prisma migrate deploy
```

---

## 🛠️ Commandes Utiles PostgreSQL

```sql
-- Lister tous les utilisateurs
\du

-- Lister toutes les bases de données
\l

-- Se connecter à une base
\c nanawax_vip

-- Lister les tables
\dt

-- Voir la structure d'une table
\d users

-- Quitter
\q
```

---

## ⚠️ Dépannage

### Erreur : "Permission denied"
```powershell
# Lancez PowerShell en tant qu'administrateur
# Puis réessayez
```

### Erreur : "role nanawax does not exist"
La base de données n'existe pas. Recommencez l'étape 3

### Erreur : "connection refused"
PostgreSQL n'est pas démarré. Sur Windows :
```powershell
# Redémarrer PostgreSQL
Restart-Service PostgreSQL-x64-15
```

### Mot de passe oublié ?
```sql
-- Se connecter comme postgres
psql -U postgres

-- Changer le mot de passe
ALTER USER nanawax WITH PASSWORD 'nouveau_mot_de_passe';

-- Quitter
\q
```

---

## 🎯 Prêt pour Nanawax !

Une fois la base de données configurée, lancez le serveur :

```bash
cd c:\laragon\www\backend-nanawax
npm start
```

Vous devriez voir :
```
✅ Connecté à la base de données
👑 Admin par défaut créé
🚀 Serveur démarré sur le port 5000
```

✨ Bon développement !
