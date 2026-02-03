-- ============================================
-- Script d'initialisation PostgreSQL
-- Nanawax VIP Database
-- ============================================

-- Créer l'utilisateur nanawax
CREATE USER IF NOT EXISTS nanawax WITH PASSWORD 'nanawax123';

-- Créer la base de données
CREATE DATABASE nanawax_vip OWNER nanawax;

-- Se connecter à la base
\c nanawax_vip

-- Donner les permissions
GRANT ALL PRIVILEGES ON DATABASE nanawax_vip TO nanawax;
GRANT USAGE ON SCHEMA public TO nanawax;
GRANT CREATE ON SCHEMA public TO nanawax;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO nanawax;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO nanawax;

-- ============================================
-- Notes :
-- - Username: nanawax
-- - Password: nanawax123
-- - Database: nanawax_vip
-- - Host: localhost
-- - Port: 5432
-- ============================================
