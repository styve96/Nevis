const jwt = require('jsonwebtoken');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

// Configuration des rôles et permissions
const ROLES = {
  ADMIN: {
    permissions: [
      'manage_users', 'view_reports', 'export_data', 'view_logs',
      'view_clients', 'add_clients', 'edit_clients', 'delete_clients',
      'view_cards', 'manage_cards', 'add_purchases', 'manage_gifts',
      'view_all_boutiques', 'system_settings'
    ]
  },
  MANAGER: {
    permissions: [
      'view_reports', 'export_data', 'view_logs',
      'view_clients', 'add_clients', 'edit_clients',
      'view_cards', 'manage_cards', 'add_purchases', 'manage_gifts',
      'view_all_boutiques'
    ]
  },
  BOUTIQUE: {
    permissions: [
      'view_reports', 'view_logs',
      'view_clients', 'add_clients', 'edit_clients',
      'view_cards', 'manage_cards', 'add_purchases', 'manage_gifts'
    ]
  },
  VENDEUR: {
    permissions: [
      'view_clients', 'add_clients',
      'view_cards', 'add_purchases'
    ]
  }
};

// Middleware d'authentification
const authenticate = async (req, res, next) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      return res.status(401).json({ error: 'Accès refusé. Token manquant.' });
    }
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const user = await prisma.user.findUnique({
      where: { id: decoded.userId }
    });
    
    if (!user || user.statut !== 'Actif') {
      return res.status(401).json({ error: 'Utilisateur non trouvé ou désactivé' });
    }
    
    // Mettre à jour la dernière connexion
    await prisma.user.update({
      where: { id: user.id },
      data: { lastLogin: new Date() }
    });
    
    req.user = {
      id: user.id,
      nom: user.nom,
      username: user.username,
      role: user.role,
      boutique: user.boutique,
      permissions: user.permissions
    };
    
    next();
  } catch (error) {
    res.status(401).json({ error: 'Token invalide' });
  }
};

// Middleware de permission
const hasPermission = (permission) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Non authentifié' });
    }
    
    // L'admin a toutes les permissions
    if (req.user.role === 'ADMIN') {
      return next();
    }
    
    // Vérifier la permission spécifique
    if (req.user.permissions.includes(permission)) {
      return next();
    }
    
    // Vérifier l'accès à la boutique
    if (permission === 'view_all_boutiques') {
      return res.status(403).json({ error: 'Accès à toutes les boutiques refusé' });
    }
    
    res.status(403).json({ error: 'Permission refusée' });
  };
};

// Vérifier l'accès à une boutique spécifique
const checkBoutiqueAccess = (boutique) => {
  return (req, res, next) => {
    if (!req.user) {
      return res.status(401).json({ error: 'Non authentifié' });
    }
    
    // Admin et Manager voient tout
    if (req.user.role === 'ADMIN' || req.user.role === 'MANAGER') {
      return next();
    }
    
    // Vérifier si l'utilisateur a accès à cette boutique
    if (req.user.boutique === boutique) {
      return next();
    }
    
    res.status(403).json({ error: `Accès refusé à la boutique ${boutique}` });
  };
};

// Générer un token JWT
const generateToken = (userId) => {
  return jwt.sign(
    { userId, timestamp: Date.now() },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || '7d' }
  );
};

module.exports = {
  authenticate,
  hasPermission,
  checkBoutiqueAccess,
  generateToken,
  ROLES
};
