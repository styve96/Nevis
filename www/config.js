// [settings] Configuration Frontend pour Nanawax VIP

const CONFIG = {
    // [public] URLs
    API_URL: 'http://localhost:5000/api',
    FRONTEND_URL: 'http://localhost:3000',
    
    // [lock] Authentification
    TOKEN_KEY: 'nanawax_token',
    USER_KEY: 'nanawax_user',
    BOUTIQUE_KEY: 'nanawax_boutique',
    TOKEN_EXPIRY_DAYS: 7,
    
    // [store] Boutiques disponibles
    BOUTIQUES: [
        { id: 1, name: 'Cotonou', code: 'CTN' },
        { id: 2, name: 'Lomé', code: 'LOM' },
        { id: 3, name: 'ITC', code: 'ITC' },
        { id: 4, name: 'Angré', code: 'ANG' },
        { id: 5, name: 'La Maison', code: 'LM' },
        { id: 6, name: 'Dakar', code: 'DKR' }
    ],
    
    // [attach_money] Configuration VIP
    LOYALTY: {
        CASES_PER_CARD: 10,
        MIN_PURCHASE_FOR_CASE: 200000, // 200.000 CFA
        CURRENCY: 'CFA',
        CURRENCY_SYMBOL: 'F'
    },
    
    // [card_giftcard] Status des cadeaux
    GIFT_STATUS: {
        EN_ATTENTE: { label: 'En attente', color: '#FFC107', badge: 'warning' },
        REMIS: { label: 'Remis', color: '#28A745', badge: 'success' },
        ANNULE: { label: 'Annulé', color: '#DC3545', badge: 'danger' }
    },
    
    // [people] Rôles utilisateurs
    ROLES: {
        ADMIN: { label: 'Administrateur', level: 4, color: '#DC3545' },
        MANAGER: { label: 'Manager', level: 3, color: '#FF6B6B' },
        BOUTIQUE: { label: 'Responsable Boutique', level: 2, color: '#4ECDC4' },
        VENDEUR: { label: 'Vendeur', level: 1, color: '#95E1D3' }
    },
    
    // [schedule] Timings
    TOAST_DURATION: 3000,
    API_TIMEOUT: 30000,
    SESSION_CHECK_INTERVAL: 60000, // 1 minute
    
    // [bar_chart] Pagination
    ITEMS_PER_PAGE: 10,
    MAX_ITEMS_PER_PAGE: 100,
    
    // [notifications] Notifications
    NOTIFICATIONS: {
        SUCCESS: 'success',
        ERROR: 'error',
        WARNING: 'warning',
        INFO: 'info'
    },
    
    // [security] Sécurité
    SECURITY: {
        PASSWORD_MIN_LENGTH: 8,
        SESSION_TIMEOUT: 86400000, // 24 heures en ms
        ALLOW_REMEMBER_ME: true
    },
    
    // [phone_android] Responsive
    BREAKPOINTS: {
        MOBILE: 576,
        TABLET: 768,
        DESKTOP: 992,
        WIDE: 1200
    },
    
    // [palette] Thème
    THEME: {
        PRIMARY_COLOR: '#2C3E50',
        SECONDARY_COLOR: '#3498DB',
        SUCCESS_COLOR: '#27AE60',
        WARNING_COLOR: '#F39C12',
        ERROR_COLOR: '#E74C3C',
        LIGHT_GRAY: '#ECF0F1',
        DARK_GRAY: '#34495E'
    }
};

// [build] Initialiser la configuration
function initConfig() {
    console.log('[settings] Configuration Nanawax VIP chargée');
    console.log('API URL:', CONFIG.API_URL);
    console.log('Boutiques disponibles:', CONFIG.BOUTIQUES.length);
}

// [done_all] Appeler l'initialisation au chargement du document
document.addEventListener('DOMContentLoaded', initConfig);
