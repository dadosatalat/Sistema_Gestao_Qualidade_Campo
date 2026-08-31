-- ==============================================================================
-- SCRIPT DE INICIALIZAÇÃO DO BANCO DE DADOS - QUALIDADE DO CAMPO (ATALAT)
-- Execute este script no SQL Editor do seu projeto Supabase:
-- https://supabase.com/dashboard/project/omkblandugynzspvwneb/sql
-- ==============================================================================

-- 1. TABELA PRINCIPAL DE SINCRONIZAÇÃO DE ESTADO (Offline-First / Realtime)
CREATE TABLE IF NOT EXISTS public.qualidade_state (
    id TEXT PRIMARY KEY DEFAULT 'default',
    state JSONB NOT NULL DEFAULT '{}'::jsonb,
    version BIGINT NOT NULL DEFAULT 1,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_by TEXT DEFAULT 'sistema'
);

-- Comentários da tabela
COMMENT ON TABLE public.qualidade_state IS 'Armazena o estado sincronizado do Sistema de Gestão de Qualidade do Campo (Agenda, NCs, Laboratório, Equipe e Histórico)';

-- 2. HABILITAR ROW LEVEL SECURITY (RLS)
ALTER TABLE public.qualidade_state ENABLE ROW LEVEL SECURITY;

-- 3. POLÍTICAS DE ACESSO (Permite leitura e gravação via chave anon / pública)
DROP POLICY IF EXISTS "Permitir leitura pública do estado" ON public.qualidade_state;
CREATE POLICY "Permitir leitura pública do estado" 
    ON public.qualidade_state 
    FOR SELECT 
    USING (true);

DROP POLICY IF EXISTS "Permitir gravação pública do estado" ON public.qualidade_state;
CREATE POLICY "Permitir gravação pública do estado" 
    ON public.qualidade_state 
    FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- 4. HABILITAR SINCRONIZAÇÃO EM TEMPO REAL (Supabase Realtime)
-- Permite que quando um técnico no campo salvar uma visita, a gestão veja na hora sem recarregar a página!
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' 
        AND schemaname = 'public' 
        AND tablename = 'qualidade_state'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.qualidade_state;
    END IF;
END $$;

-- 5. TABELA DE AUDITORIA / LOGS DE SINCRONIZAÇÃO (Opcional, para histórico)
CREATE TABLE IF NOT EXISTS public.sync_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    action TEXT NOT NULL,
    user_mode TEXT,
    details JSONB,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

ALTER TABLE public.sync_logs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Permitir inserção de logs" ON public.sync_logs;
CREATE POLICY "Permitir inserção de logs" 
    ON public.sync_logs 
    FOR INSERT 
    WITH CHECK (true);

DROP POLICY IF EXISTS "Permitir leitura de logs" ON public.sync_logs;
CREATE POLICY "Permitir leitura de logs" 
    ON public.sync_logs 
    FOR SELECT 
    USING (true);

-- ==============================================================================
-- PRONTO! O script foi executado com sucesso.
-- Agora seu Supabase está preparado para receber os dados do aplicativo.
-- ==============================================================================
