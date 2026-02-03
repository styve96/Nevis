const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');
require('dotenv').config();

const app = express();
const prisma = new PrismaClient();

// Configuration
const PORT = process.env.PORT || 5000;
const FRONTEND_URL = process.env.FRONTEND_URL || 'http://localhost:3000';

// Middleware de sécurité
app.use(helmet());
app.use(cors({
  origin: FRONTEND_URL,
  credentials: true
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limite chaque IP à 100 requêtes par fenêtre
});
app.use('/api/', limiter);

// Middleware pour parser le JSON
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Import des routes
const authRoutes = require('./src/routes/auth');

// Routes
app.use('/api/auth', authRoutes);

// Route de santé
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    version: '2.0.0'
  });
});

// Route GET clients (sans authentification pour tester)
app.get('/api/clients', async (req, res) => {
  try {
    const clients = await prisma.client.findMany({
      take: 20,
      orderBy: { dateCreation: 'desc' }
    });
    res.json({
      success: true,
      data: clients,
      pagination: {
        total: await prisma.client.count(),
        page: 1,
        limit: 20,
        pages: 1
      }
    });
  } catch (error) {
    console.error('Erreur récupération clients:', error);
    res.status(500).json({ error: 'Erreur interne du serveur' });
  }
});

// Route POST achats (enregistrement)
app.post('/api/achats', async (req, res) => {
  try {
    const { clientId, montant, boutique, numFacture, vendeur } = req.body;
    
    if (!clientId || !montant || !boutique) {
      return res.status(400).json({ error: 'Champs requis manquants' });
    }
    
    const eligible = montant >= 200000;
    
    const achat = await prisma.achat.create({
      data: {
        clientId: parseInt(clientId),
        montant: parseFloat(montant),
        boutique,
        numFacture: numFacture || `FAC-${Date.now()}`,
        vendeur: vendeur || 'Vendeur',
        eligible,
        date: new Date(),
        dateISO: new Date().toISOString()
      }
    });
    
    res.status(201).json({
      success: true,
      message: 'Achat enregistré avec succès',
      data: achat
    });
  } catch (error) {
    console.error('Erreur enregistrement achat:', error);
    res.status(500).json({ error: 'Erreur interne du serveur' });
  }
});

// Route GET cadeaux
app.get('/api/cadeaux', async (req, res) => {
  try {
    const cadeaux = await prisma.cadeau.findMany({
      orderBy: { dateISO: 'desc' }
    });
    res.json({
      success: true,
      data: cadeaux
    });
  } catch (error) {
    console.error('Erreur récupération cadeaux:', error);
    res.status(500).json({ error: 'Erreur interne du serveur' });
  }
});

// Gestion des erreurs 404
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Route non trouvée' });
});

// Gestionnaire d'erreurs global
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Erreur interne du serveur',
    message: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// Initialisation de l'application
async function initializeApp() {
  try {
    // Vérifier la connexion à la base de données
    await prisma.$connect();
    console.log('[done_all] Connecté à la base de données');
    
    // Créer l'admin par défaut si non existant
    const adminExists = await prisma.user.findFirst({
      where: { username: 'admin' }
    });
    
    if (!adminExists) {
      const hashedPassword = await bcrypt.hash('admin123', 12);
      await prisma.user.create({
        data: {
          nom: 'Administrateur Principal',
          username: 'admin',
          passwordHash: hashedPassword,
          role: 'ADMIN',
          permissions: [
            'manage_users', 'view_reports', 'export_data', 'view_logs',
            'view_clients', 'add_clients', 'edit_clients', 'delete_clients',
            'view_cards', 'manage_cards', 'add_purchases', 'manage_gifts',
            'view_all_boutiques', 'system_settings'
          ],
          createdBy: 'system'
        }
      });
      console.log('[crown] Admin par défaut créé (username: admin, password: admin123)');
    }
    
    // Démarrer le serveur
    app.listen(PORT, () => {
      console.log(`\n[rocket] Serveur démarré sur le port ${PORT}`);
      console.log(`[bar_chart] Interface Frontend: ${FRONTEND_URL}`);
      console.log(`[link] API Base URL: http://localhost:${PORT}/api`);
      console.log(`[favorite] Health Check: http://localhost:${PORT}/api/health\n`);
    });
    
  } catch (error) {
    console.error('[close] Erreur d\'initialisation:', error);
    process.exit(1);
  }
}

// Gestion de la fermeture propre
process.on('SIGTERM', async () => {
  console.log('🔻 Arrêt du serveur...');
  await prisma.$disconnect();
  process.exit(0);
});

process.on('SIGINT', async () => {
  console.log('\n🔻 Arrêt du serveur...');
  await prisma.$disconnect();
  process.exit(0);
});

// Initialiser l'application
initializeApp();

module.exports = app;
