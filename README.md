# 🥛 Sistema de Gestão de Qualidade no Campo — Atalat (Online)

Aplicação web para gestão técnica e controle de qualidade de leite no campo, com suporte a **sincronização em tempo real na nuvem (Supabase)**, **modo offline para técnicos na zona rural**, versionamento com **Git** e deploy contínuo na **Vercel**.

---

## 🚀 Como Colocar no Ar (Passo a Passo)

### 1. Configurar o Banco de Dados no Supabase
1. Acesse o seu projeto no Supabase: [https://supabase.com/dashboard/project/omkblandugynzspvwneb](https://supabase.com/dashboard/project/omkblandugynzspvwneb)
2. No menu lateral esquerdo, clique no ícone **SQL Editor**.
3. Clique em **New query**.
4. Copie todo o conteúdo do arquivo [`supabase-schema.sql`](./supabase-schema.sql) deste repositório, cole no editor e clique em **Run** (botão verde).
5. Isso criará a tabela `qualidade_state` com **Row Level Security (RLS)** e **Realtime** habilitados.

---

### 2. Obter sua Chave Pública (`anon key`) do Supabase
1. No painel do Supabase, clique no ícone de engrenagem no canto inferior esquerdo (**Project Settings**).
2. Vá na aba **API**.
3. Na seção **Project API keys**, copie a chave chamada **`anon` `public`** (ela começa com `eyJhbGci...`).
4. No aplicativo web (ou ao abrir no navegador), clique no botão **☁️ Nuvem / Supabase** no topo e cole sua chave. Ela ficará salva com segurança no navegador!

---

### 3. Subir o Projeto para o GitHub / GitLab (Git)

No terminal na pasta do projeto, execute:

```bash
# 1. Inicializar repositório Git
git init

# 2. Adicionar os arquivos
git add .

# 3. Criar o primeiro commit
git commit -m "feat: Sistema de Gestão de Qualidade do Campo integrado com Supabase e Vercel"

# 4. Conectar ao seu repositório no GitHub (substitua pelo link do seu repositório)
git remote add origin https://github.com/SEU-USUARIO/app-qualidade-campo.git
git branch -M main
git push -u origin main
```

---

### 4. Publicar na Vercel

1. Acesse [vercel.com](https://vercel.com) e faça login com sua conta do GitHub.
2. Clique em **Add New...** > **Project**.
3. Selecione o repositório `app-qualidade-campo` que você acabou de enviar.
4. No campo **Framework Preset**, deixe como **Other** (ou padrão).
5. Clique em **Deploy**.
6. Em menos de 1 minuto seu sistema estará no ar com HTTPS gratuito (ex.: `https://app-qualidade-campo.vercel.app`)!

---

## ⚡ Funcionalidades Online & Offline

* **🟢 Modo Online / Sincronizado:** Todas as alterações feitas por gestores ou técnicos no escritório ou no campo são salvas instantaneamente no banco PostgreSQL do Supabase.
* **⚡ Tempo Real (Realtime):** Se um técnico concluir uma visita ou salvar uma nota na fazenda, a tela da gestão atualiza automaticamente sem precisar recarregar a página (`F5`).
* **🔴 Modo Offline-First (Zona Rural):** Quando o técnico estiver em uma área sem sinal de celular (3G/4G), o sistema continua funcionando 100%, salvando as visitas na memória do aparelho. Assim que o aparelho reconectar à internet, os dados são enviados automaticamente para a nuvem.
* **👩‍💼 Modo Gestão vs 🧑‍🔧 Modo Técnico:** Alternância rápida entre visão analítica completa da gestão e visão simplificada do dia a dia do técnico.
* **📊 Importação R203 & NC:** Processamento de planilhas Excel `.xlsx` e `.csv` direto no navegador.

---

## 📁 Estrutura de Arquivos

* `index.html`: Aplicação web completa com integração ao Supabase e suporte offline.
* `supabase-schema.sql`: Script SQL para inicialização do banco de dados no Supabase.
* `vercel.json`: Configuração de rotas para a Vercel.
* `.gitignore`: Arquivos ignorados no versionamento.
* `README.md`: Este guia de configuração e deploy.
