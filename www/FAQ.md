# [help] FAQ & TROUBLESHOOTING - Nanawax VIP

> Guide de dépannage et réponses aux questions fréquentes

---

## [stop] ERREURS COURANTES ET SOLUTIONS

### [close] "Cannot find module 'express'"

**Symptôme:**
```
Error: Cannot find module 'express'
```

**Cause:** Les dépendances npm ne sont pas installées

**Solution:**
```powershell
cd c:\laragon\www\backend-nanawax
npm install
npm start
```

**Vérification:**
- Assurez-vous d'être dans le dossier `backend-nanawax`
- Assurez-vous que `node_modules` existe
- Vérifiez que npm ne montre pas d'erreurs

---

### [close] "Error: connect ECONNREFUSED 127.0.0.1:5432"

**Symptôme:**
```
Error: connect ECONNREFUSED 127.0.0.1:5432
```

**Cause:** PostgreSQL n'est pas en cours d'exécution

**Solution:**
```powershell
# Option 1: Démarrer via Services
Restart-Service PostgreSQL-x64-15

# Option 2: Vérifier l'état
Get-Service PostgreSQL* | Select Name, Status

# Option 3: Via GUI
# Services (services.msc) → PostgreSQL → Démarrer
```

**Vérification:**
- Ouvrez "Services" (services.msc)
- Cherchez "PostgreSQL"
- Assurez-vous que le statut est "Running"

---

### [close] "EADDRINUSE :::5000"

**Symptôme:**
```
Error: listen EADDRINUSE :::5000
```

**Cause:** Le port 5000 est déjà en utilisation

**Solution Option 1: Changer le port**
Éditez `.env`:
```env
PORT=5001
```

**Solution Option 2: Libérer le port**
```powershell
# Trouver ce qui utilise le port 5000
netstat -ano | findstr :5000

# Tuer le processus (remplacer PID par le numéro)
taskkill /PID 1234 /F
```

**Vérification:**
```powershell
netstat -ano | findstr :5000
# Ne devrait rien retourner
```

---

### [close] "password authentication failed"

**Symptôme:**
```
FATAL: password authentication failed for user "nanawax"
```

**Cause:** Mauvais mot de passe PostgreSQL

**Solution:**
```powershell
# Recréer l'utilisateur avec le setup script
powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1

# OU manuellement:
psql -U postgres -h localhost

# Dans psql:
ALTER USER nanawax WITH PASSWORD 'nanawax123';
\q
```

**Vérification:**
```powershell
psql -U nanawax -d nanawax_vip -h localhost -c "SELECT 1"
# Devrait afficher: 1
```

---

### [close] "role nanawax does not exist"

**Symptôme:**
```
FATAL: role "nanawax" does not exist
```

**Cause:** L'utilisateur PostgreSQL n'existe pas

**Solution:**
```powershell
# Recréer les utilisateurs
powershell -ExecutionPolicy Bypass -File setup-postgresql.ps1

# Ou manuellement:
psql -U postgres -h localhost

# Dans psql:
CREATE USER nanawax WITH PASSWORD 'nanawax123';
CREATE DATABASE nanawax_vip OWNER nanawax;
GRANT ALL PRIVILEGES ON DATABASE nanawax_vip TO nanawax;
\q
```

---

### [close] "relation ... does not exist"

**Symptôme:**
```
ERROR: relation "users" does not exist
```

**Cause:** Les tables de la base de données n'existent pas

**Solution:**
```powershell
# Déployer les migrations
npx prisma migrate deploy

# Si ça ne marche pas, réinitialiser:
npx prisma migrate reset --force
```

**Vérification:**
```powershell
# Vérifier les tables
psql -U nanawax -d nanawax_vip -h localhost -c "\dt"

# Devrait afficher une liste de tables
```

---

### ❌ "Uncaught SyntaxError in index.html"

**Symptôme:**
```
Uncaught SyntaxError: Unexpected token ...
# Dans la console du navigateur (F12)
```

**Cause:** Erreur JavaScript ou fichier manquant

**Solution:**
1. **Ouvrir F12** → Onglet "Console"
2. **Vérifier l'erreur exacte**
3. **Chercher le fichier manquant**
4. **Vérifier la syntaxe JavaScript**

**Exemples de vérifications:**
```javascript
// Dans console (F12):
CONFIG.API_URL      // Doit afficher l'URL
localStorage        // Doit fonctionner
```

---

### ❌ "CORS error: Access to XMLHttpRequest blocked"

**Symptôme:**
```
Access to XMLHttpRequest from origin 'file://' has been blocked by CORS policy
```

**Cause:** Le frontend n'est pas sur le même serveur que l'API

**Solution:**
Assurez-vous que:
1. Le backend est lancé: `npm start`
2. `config.js` a `API_URL: 'http://localhost:5000/api'`
3. Le `.env` a `FRONTEND_URL=http://localhost:3000`

**Test:**
```powershell
# Vérifier que l'API répond
curl http://localhost:5000/api/health
# Devrait retourner JSON avec status: OK
```

---

### ❌ "Token expired or invalid"

**Symptôme:**
```
Error: Token expired or invalid
```

**Cause:** Votre session a expiré

**Solution:**
1. **Rafraîchir la page** (F5)
2. **Vous reconnecter** avec vos identifiants
3. **Vider le cache** si ça persiste (Ctrl+Shift+Delete)

**Prévention:**
- Le token expire après 7 jours
- Vous recevrez une alerte avant l'expiration

---

### ❌ "Cannot GET /api/clients"

**Symptôme:**
```
Cannot GET /api/clients
```

**Cause:** Endpoint API introuvable

**Solution:**
1. **Vérifier l'URL** - Doit être `http://localhost:5000/api/clients`
2. **Vérifier que le serveur tourne** - Voir les logs
3. **Vérifier l'authentification** - Envoyez le JWT token
4. **Vérifier les permissions** - Vous avez les droits?

**Test:**
```powershell
curl http://localhost:5000/api/health
# Doit retourner {"status":"OK",...}
```

---

### ❌ "npm ERR! 404 Not Found"

**Symptôme:**
```
npm ERR! 404 Not Found - GET ...
```

**Cause:** Package npm introuvable sur npmjs.com

**Solution:**
```powershell
# Vérifier l'orthographe dans package.json
# Réinstaller
rm -r node_modules package-lock.json
npm install
```

---

### ❌ "Disk quota exceeded"

**Symptôme:**
```
Disk quota exceeded
```

**Cause:** Pas assez d'espace disque

**Solution:**
```powershell
# Supprimer les fichiers inutiles
rm -r node_modules

# Nettoyer npm cache
npm cache clean --force

# Réinstaller
npm install
```

---

## ❓ FAQ - QUESTIONS FRÉQUENTES

### Q: Comment changer le port du serveur?
**R:** Modifiez `.env`:
```env
PORT=5001
```
Redémarrez le serveur.

---

### Q: Comment réinitialiser complètement la base de données?
**R:**
```powershell
npx prisma migrate reset --force
```
⚠️ Cela efface TOUTES les données !

---

### Q: Comment sauvegarder ma base de données?
**R:**
```powershell
pg_dump -U nanawax nanawax_vip > backup.sql
```

Pour restaurer:
```powershell
psql -U nanawax nanawax_vip < backup.sql
```

---

### Q: Comment ajouter un nouvel utilisateur?
**R:**
Dans le frontend, connectez-vous en admin et allez à Paramètres → Utilisateurs → Ajouter.

Ou en base de données:
```sql
INSERT INTO users (email, password, role, boutique_id)
VALUES ('user@example.com', 'hashed_password', 'VENDEUR', 1);
```

---

### Q: Comment changer le JWT_SECRET?
**R:**
Pour sécuriser votre production, changez dans `.env`:
```env
JWT_SECRET=votre_nouvelle_cle_tres_securisee_12345...
```

Redémarrez le serveur. Tous les tokens actuels seront invalidés.

---

### Q: Où sont stockées les données?
**R:**
Dans PostgreSQL à l'adresse:
```
Server: localhost:5432
User: nanawax
Database: nanawax_vip
```

Pour explorer:
```powershell
npx prisma studio
```

---

### Q: Comment exporter les données?
**R:**
1. Allez à l'onglet "📤 Export"
2. Sélectionnez les données
3. Cliquez "Télécharger Excel"

Ou via SQL:
```powershell
psql -U nanawax -d nanawax_vip -h localhost -c "SELECT * FROM clients;" > clients.csv
```

---

### Q: Combien de clients peut gérer le système?
**R:**
Théoriquement illimité. Pratiquement:
- 10.000 clients: Pas de problème
- 100.000+ clients: Peut avoir besoin d'optimisation
- Besoin d'indexation avancée pour 1M+

---

### Q: Comment faire un backup automatique?
**R:**
Créez une tâche Windows planifiée:

```powershell
# Script backup.ps1
$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
pg_dump -U nanawax nanawax_vip > "C:\backups\nanawax_$timestamp.sql"
```

Programmez cette tâche à minuit chaque jour.

---

### Q: Puis-je utiliser MySQL au lieu de PostgreSQL?
**R:**
Non, le système est conçu pour PostgreSQL. Mais vous pouvez adapter:
1. Changez `DATABASE_URL` dans `.env` vers MySQL
2. Modifiez `prisma/schema.prisma`
3. Changez le provider en `mysql`
4. Exécutez `npx prisma migrate deploy`

**Attention:** Cela nécessite des connaissances techniques avancées.

---

### Q: Comment multiplier la vitesse?
**R:**
1. **Ajouter des index** à la base de données
2. **Ajouter Redis** pour le cache
3. **Paginer les requêtes** (déjà fait)
4. **Optimiser les requêtes** SQL
5. **Ajouter un CDN** pour les fichiers statiques

Consultez README.md pour plus de détails.

---

### Q: Comment ajouter HTTPS/SSL?
**R:**
Pour production:
```bash
# Installer certbot
sudo apt-get install certbot python3-certbot-nginx

# Générer un certificat
sudo certbot certonly --standalone -d votredomaine.com

# Configurer dans votre nginx/Apache
```

Pour développement local, ce n'est pas nécessaire.

---

### Q: Comment gérer plusieurs boutiques?
**R:**
Le système gère déjà les multi-boutiques:
- Chaque utilisateur est assigné à une boutique
- Les données sont filtrées par boutique
- Les admins voient tout

Pour ajouter une boutique:
```javascript
// Dans config.js:
BOUTIQUES: [
    ...existantes,
    { id: 7, name: 'Nouvelle', code: 'NV' }
]
```

---

### Q: Puis-je utiliser le système sur mon téléphone?
**R:**
Oui! Mais:
- C'est une web app, pas une application native
- Fonctionne sur smartphone via navigateur
- Version mobile à améliorer (v2.1+)
- Recommandé sur desktop pour les opérations critiques

---

### Q: Quelle est la capacité maximum de données?
**R:**
Avant optimisation:
- **Clients:** 50.000+
- **Achats:** 1.000.000+
- **Cadeaux:** 10.000+

Après optimisation (index, cache):
- **Clients:** 1.000.000+
- **Achats:** 10.000.000+
- **Cadeaux:** 100.000+

---

### Q: Comment déployer en production?
**R:**
Voir [DEPLOYMENT.md] (à créer). En résumé:
1. Louer un serveur (Digital Ocean, AWS, etc.)
2. Installer Node.js et PostgreSQL
3. Cloner le code
4. Configurer `.env` pour production
5. Lancer avec `npm start`
6. Configurer un reverse proxy (nginx)
7. Ajouter HTTPS
8. Mettre en place backups automatiques

---

## 🔧 DIAGNOSTIQUES UTILES

### Vérifier tout le système

```powershell
# Node.js
node --version          # Doit être v18+

# npm
npm --version           # Doit être 8+

# PostgreSQL
psql --version          # Doit être 12+

# Backend
curl http://localhost:5000/api/health

# Base de données
psql -U nanawax -d nanawax_vip -h localhost -c "SELECT COUNT(*) FROM users;"
```

---

### Voir les logs

**Backend:**
```powershell
npm start
# Les logs s'affichent directement dans la console
```

**PostgreSQL:**
```powershell
# Voir le fichier de log (localisation varie selon installation)
# Sur Windows: C:\Program Files\PostgreSQL\15\data\pg_log\

# Ou checker depuis psql:
psql -U postgres -c "SHOW log_directory;"
```

**Frontend:**
```
F12 → Onglet Console
```

---

## 📞 CONTACTER LE SUPPORT

Si vous ne trouvez pas la solution:

1. **Consultez la documentation:**
   - START_HERE.md
   - QUICK_START.md
   - README.md

2. **Vérifiez les logs:**
   - Console du serveur
   - Console du navigateur (F12)

3. **Essayez le dépannage:**
   - Redémarrez le serveur
   - Videz le cache (Ctrl+Shift+Delete)
   - Réinstallez les packages (`npm install`)

4. **Contactez l'équipe:**
   - 📧 support@nanawax.com
   - 📞 +226 XX XX XX XX
   - 🌐 www.nanawax.com

---

## ✅ AVANT DE CONTACTER LE SUPPORT

Assurez-vous d'avoir:
- [ ] Redémarré le serveur
- [ ] Vérifié les logs
- [ ] Consulté cette FAQ
- [ ] Essayé les solutions suggérées
- [ ] Noté l'erreur exacte
- [ ] Noté ce que vous faisiez quand ça s'est produit

---

**Merci de votre compréhension et de votre confiance en Nanawax VIP !** 🙏

---

_FAQ v2.0 - Nanawax VIP_  
_Dernière mise à jour: 2024_
