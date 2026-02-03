const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { PrismaClient } = require('@prisma/client');
const { generateToken, ROLES } = require('../middleware/auth');
const Joi = require('joi');

const prisma = new PrismaClient();

// Schéma de validation
const loginSchema = Joi.object({
  username: Joi.string().required(),
  password: Joi.string().required(),
  boutique: Joi.string().optional().allow('')
});

const changePasswordSchema = Joi.object({
  currentPassword: Joi.string().required(),
  newPassword: Joi.string().min(6).required(),
  confirmPassword: Joi.string().valid(Joi.ref('newPassword')).required()
});

// Connexion
router.post('/login', async (req, res) => {
  try {
    // Validation
    const { error, value } = loginSchema.validate(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }
    
    const { username, password, boutique } = value;
    
    // Chercher l'utilisateur
    const user = await prisma.user.findUnique({
      where: { username }
    });
    
    if (!user) {
      return res.status(401).json({ error: 'Identifiants incorrects' });
    }
    
    // Vérifier le mot de passe
    const isValidPassword = await bcrypt.compare(password, user.passwordHash);
    if (!isValidPassword) {
      return res.status(401).json({ error: 'Identifiants incorrects' });
    }
    
    // Vérifier le statut
    if (user.statut !== 'Actif') {
      return res.status(403).json({ error: 'Compte désactivé' });
    }
    
    // Vérifier l'accès boutique pour certains rôles
    if (user.role === 'BOUTIQUE' || user.role === 'VENDEUR') {
      if (!user.boutique) {
        return res.status(403).json({ error: 'Aucune boutique assignée' });
      }
      
      if (boutique && boutique !== user.boutique) {
        return res.status(403).json({ error: `Boutique incorrecte. Attendu: ${user.boutique}` });
      }
    }
    
    // Générer le token
    const token = generateToken(user.id);
    
    // Journaliser la connexion
    await prisma.journal.create({
      data: {
        type: 'systeme',
        action: 'Connexion',
        details: `Utilisateur ${user.nom} connecté`,
        userId: user.id
      }
    });
    
    // Créer une notification de bienvenue
    await prisma.notification.create({
      data: {
        titre: 'Bienvenue',
        message: `Bonjour ${user.nom}, bienvenue dans le système de gestion VIP.`,
        type: 'info',
        userId: user.id
      }
    });
    
    // Réponse
    res.json({
      success: true,
      token,
      user: {
        id: user.id,
        nom: user.nom,
        username: user.username,
        role: user.role,
        boutique: user.boutique,
        permissions: user.permissions
      }
    });
    
  } catch (error) {
    console.error('Erreur connexion:', error);
    res.status(500).json({ error: 'Erreur interne du serveur' });
  }
});

// Changer le mot de passe
router.post('/change-password', async (req, res) => {
  try {
    const { error, value } = changePasswordSchema.validate(req.body);
    if (error) {
      return res.status(400).json({ error: error.details[0].message });
    }
    
    const { currentPassword, newPassword } = value;
    const userId = req.user?.id;
    
    if (!userId) {
      return res.status(401).json({ error: 'Non authentifié' });
    }
    
    const user = await prisma.user.findUnique({
      where: { id: userId }
    });
    
    if (!user) {
      return res.status(404).json({ error: 'Utilisateur non trouvé' });
    }
    
    // Vérifier l'ancien mot de passe
    const isValidPassword = await bcrypt.compare(currentPassword, user.passwordHash);
    if (!isValidPassword) {
      return res.status(400).json({ error: 'Mot de passe actuel incorrect' });
    }
    
    // Hasher le nouveau mot de passe
    const hashedPassword = await bcrypt.hash(newPassword, 12);
    
    // Mettre à jour
    await prisma.user.update({
      where: { id: userId },
      data: { passwordHash: hashedPassword }
    });
    
    // Journaliser
    await prisma.journal.create({
      data: {
        type: 'utilisateur',
        action: 'Changement mot de passe',
        details: 'Mot de passe changé avec succès',
        userId: userId
      }
    });
    
    res.json({ success: true, message: 'Mot de passe changé avec succès' });
    
  } catch (error) {
    console.error('Erreur changement mot de passe:', error);
    res.status(500).json({ error: 'Erreur interne du serveur' });
  }
});

// Déconnexion
router.post('/logout', async (req, res) => {
  try {
    const userId = req.user?.id;
    
    if (userId) {
      await prisma.journal.create({
        data: {
          type: 'systeme',
          action: 'Déconnexion',
          details: `Utilisateur déconnecté`,
          userId: userId
        }
      });
    }
    
    res.json({ success: true, message: 'Déconnecté avec succès' });
    
  } catch (error) {
    console.error('Erreur déconnexion:', error);
    res.status(500).json({ error: 'Erreur interne du serveur' });
  }
});

// Vérifier le token
router.get('/verify', async (req, res) => {
  try {
    const token = req.header('Authorization')?.replace('Bearer ', '');
    
    if (!token) {
      return res.json({ valid: false });
    }
    
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    const user = await prisma.user.findUnique({
      where: { id: decoded.userId }
    });
    
    if (!user || user.statut !== 'Actif') {
      return res.json({ valid: false });
    }
    
    res.json({ 
      valid: true,
      user: {
        id: user.id,
        nom: user.nom,
        username: user.username,
        role: user.role,
        boutique: user.boutique,
        permissions: user.permissions
      }
    });
    
  } catch (error) {
    res.json({ valid: false });
  }
});

module.exports = router;
