// CONTRIBUTING.md

---
type: guidelines
role: project-conventions
version: 1.0.0
project: llm-readable-kit
status: approved
priority: critical
keywords: [conventions, naming, standards, guidelines]
consumes: []
feeds: [GLOSSARY.md, VERSIONING.md, schemas/document-schema.json]
---

# Guia de Contribuição e Convenções

> **📖 Termos técnicos:** Consulte [GLOSSARY.md](./GLOSSARY.md) para definições canônicas

## 🔗 Mapa de Dependências

### ⬆️ Upstream (O que este documento consome)
- Nenhum - Este é um documento raiz de convenções

### ⬇️ Downstream (O que este documento alimenta)
- **[GLOSSARY.md](./GLOSSARY.md)** - Define termos padronizados aqui estabelecidos
- **[VERSIONING.md](./VERSIONING.md)** - Aplica padrões de versionamento
- **[schemas/document-schema.json](./schemas/document-schema.json)** - Valida conformidade
- **Todos os arquivos do projeto** - Devem seguir estas convenções

---

## 📋 Convenções de Nomenclatura

### 1. Documentos Principais (Root Level)
**Padrão:** `<NOME_EM_CAPS>.md`

Documentos críticos que orquestram ou definem o projeto:
- ✅ `CODEX_TASK.md` - Entry point para agentes
- ✅ `GLOSSARY.md` - Glossário canônico de termos
- ✅ `CONTEXT_INDEX.json` - Índice de contexto dinâmico
- ✅ `CONTRIBUTING.md` - Este arquivo
- ✅ `README.md` - Visão geral do projeto
- ✅ `VERSIONING.md` - Padrões de versionamento
- ✅ `CHANGELOG.md` - Histórico de mudanças

**Quando criar novo:** Apenas para documentos que serão referenciados por múltiplos outros arquivos como fonte de verdade (SSOT - Single Source of Truth).

---

### 2. Chunks Modulares (chunks/)
**Padrão:** `chunks/NN-<nome-kebab-case>.md`

Numeração sequencial obrigatória (00-99):
- ✅ `chunks/00-context.md` - Escopo e objetivo
- ✅ `chunks/01-files.md` - Arquivos-alvo
- ✅ `chunks/08-validation.md` - Validação e scoring

**Regras:**
- Numeração define ordem de leitura lógica
- Nome em kebab-case (minúsculas com hífen)
- Máximo 120 linhas por chunk
- Cada chunk = 1 preocupação completa (idempotente)
- Sempre adicionar metadados YAML no início

**Exemplo de novo chunk:**
```markdown
***
type: chunk
chunk_number: 09
kit_version: 1.0.0
role: error-handling
keywords: [errors, exceptions, resilience]
consumes: [chunks/08-validation.md]
feeds: [components/]
***

# 09 - Error Handling

[conteúdo]
```

---

### 3. Protocolos e Métodos (protocols/)
**Padrão:** `protocols/<nome>-protocol-v<X.Y>.md`

Para definições de metodologia reutilizáveis:
- ✅ `protocols/fundation-agent-protocol-v1.0.md`
- ✅ `protocols/HITL-gate-protocol-v1.0.md`
- ✅ `protocols/intake-process-protocol-v2.0.md`

**Regras:**
- Versão no nome do arquivo (facilita coexistência de versões)
- Quando fizer breaking change, criar novo arquivo v2.0
- Manter versões antigas por 1 ciclo de release para compatibilidade

**Exemplo de evolução:**
```
protocols/fundation-agent-protocol-v1.0.md  (deprecated, mantido por compatibilidade)
protocols/fundation-agent-protocol-v2.0.md  (versão atual)
```

---

### 4. Templates de Referência (templates/)
**Padrão:** `templates/<projeto-origem>-<tipo>-<feature>.md`

Para documentos que servem como exemplo de outros projetos:
- ✅ `templates/mywai-feature-progressbar.md`
- ✅ `templates/enevr-architecture-modular.md`
- ✅ `templates/generic-feature-template.md`

**Quando usar:**
- Exemplo estrutural de outro projeto
- Template genérico reutilizável
- Caso de referência homologado

**Diferença vs examples/:**
- `templates/` = Para ser copiado e adaptado (mutável no contexto do novo projeto)
- `examples/` = Para ser lido como referência (read-only, imutável)

**Migração de arquivos atuais:**
```bash
# Arquivo atual ambíguo
feature-recurso-progressbar.md

# Deve ser renomeado para
templates/mywai-feature-progressbar.md
```

---

### 5. Exemplos Homologados (examples/)
**Padrão:** `examples/<feature>-example-v<X.Y>.md`

Documentos read-only que servem como referência canônica:
- ✅ `examples/semantic-export-example-v1.0.md`
- ✅ `examples/full-pipeline-example-v1.0.md`

**Características:**
- Imutável (não editar após homologação)
- Versionado no nome
- Aprovado pelo Operador (HITL)
- Serve como "gold standard" do kit

**Quando criar:**
- Após um entregável em `components/` ser aprovado e considerado exemplar
- Quando um caso de uso se torna referência para futuros projetos

---

### 6. Entregáveis Ativos (components/)
**Padrão:** `components/llm-readable-<feature>-v<X.Y>-<status>.md`

Status possíveis: `draft`, `review`, `approved`

- ✅ `components/llm-readable-semantic-export-v1.0-approved.md`
- ✅ `components/llm-readable-analytics-dashboard-v0.9-review.md`
- ✅ `components/llm-readable-auth-flow-v0.1-draft.md`

**Ciclo de vida:**
1. Agente gera: `llm-readable-<feature>-v0.1-draft.md`
2. Operador revisa: renomeia para `v0.2-review.md` (iterações mantêm 0.x)
3. Após aprovação: renomeia para `v1.0-approved.md`
4. Se obsoleto: move para `components/archive/`

**Regras de versionamento:**
- Draft começa em v0.1
- Review pode iterar (v0.2, v0.3...) antes de aprovação
- Approved promove para v1.0 ou incrementa major/minor conforme VERSIONING.md
- Sempre incluir version E status no nome

**Migração de arquivos atuais:**
```bash
# Arquivo atual sem padrão claro
framework-llm-readable.semantic-export.md

# Deve ser movido/renomeado para
components/llm-readable-semantic-export-v1.0-approved.md
# OU (se ainda é referência)
examples/semantic-export-example-v1.0.md
```

---

### 7. Schemas (schemas/)
**Padrão:** `schemas/<nome>-schema.json`

Schemas de validação JSON Schema:
- ✅ `schemas/document-schema.json`
- ✅ `schemas/metadata-schema.json`
- ✅ `schemas/context-index-schema.json`

**Quando criar:**
- Para validar estrutura de documentos
- Para validar dados em JSON (como CONTEXT_INDEX.json)
- Para garantir conformidade automática

---

### 8. Scripts (scripts/)
**Padrão:** `scripts/<ação>-<objeto>.<extensão>`

Scripts de automação:
- ✅ `scripts/validate-documents.js` - Validação de documentos
- ✅ `scripts/migrate-naming.sh` - Migração de nomenclatura
- ✅ `scripts/generate-context-index.js` - Geração de índice

**Extensões:**
- `.js` - JavaScript/Node.js
- `.sh` - Shell script (Bash)
- `.py` - Python

---

## 📂 Estrutura de Pastas Completa

```
llm-readable-kit/
├── CODEX_TASK.md                    # Entry point (orquestrador)
├── GLOSSARY.md                      # Glossário canônico
├── CONTEXT_INDEX.json               # Índice de contexto dinâmico
├── CONTRIBUTING.md                  # Este arquivo
├── VERSIONING.md                    # Padrões de versionamento
├── CHANGELOG.md                     # Histórico de mudanças
├── README.md                        # Visão geral
├── LICENSE                          
├── package.json                     # Dependências Node.js
├── .gitignore                       
│
├── .github/
│   └── workflows/
│       └── validate-docs.yml        # CI/CD validação automática
│
├── chunks/                          # Chunks modulares atômicos
│   ├── 00-context.md
│   ├── 01-files.md
│   ├── 02-ingest.md
│   ├── 03-enrich.md
│   ├── 04-project.md
│   ├── 05-deliver.md
│   ├── 06-lookup-tables.md
│   ├── 07-invariants.md
│   └── 08-validation.md
│
├── protocols/                       # Protocolos e metodologias
│   ├── fundation-agent-protocol-v1.0.md
│   └── HITL-gate-protocol-v1.0.md
│
├── templates/                       # Templates de outros projetos
│   ├── mywai-feature-progressbar.md
│   ├── enevr-architecture-modular.md
│   └── generic-feature-template.md
│
├── examples/                        # Exemplos homologados read-only
│   ├── semantic-export-example-v1.0.md
│   └── full-pipeline-example-v1.0.md
│
├── components/                      # Entregáveis ativos
│   ├── llm-readable-semantic-export-v1.0-approved.md
│   ├── llm-readable-analytics-dashboard-v0.9-review.md
│   └── archive/                     # Entregáveis obsoletos
│       └── llm-readable-old-feature-v0.5-archived.md
│
├── schemas/                         # Schemas de validação
│   ├── document-schema.json
│   ├── metadata-schema.json
│   └── context-index-schema.json
│
├── scripts/                         # Automações
│   ├── validate-documents.js
│   ├── generate-context-index.js
│   └── migrate-naming.sh
│
└── docs/                            # Documentação adicional
    ├── MIGRATION_GUIDE.md
    ├── QUICK_START.md
    └── reference-study-sop.md       # Contexto histórico
```

---

## 🔄 Metadados YAML Obrigatórios

Todo arquivo `.md` DEVE ter frontmatter YAML no início:

```yaml
***
type: <tipo>                    # obrigatório
version: <X.Y.Z>                # obrigatório
role: <papel>                   # obrigatório
status: <status>                # recomendado
priority: <prioridade>          # recomendado
keywords: [<tag1>, <tag2>]      # recomendado
consumes: [<arquivo1.md>]       # recomendado
feeds: [<arquivo2.md>]          # recomendado
***
```

### Campos Obrigatórios:

**type:** (valores permitidos)
- `orchestrator` - Documento que coordena workflow (ex: CODEX_TASK.md)
- `protocol` - Define metodologia/processo
- `chunk` - Módulo atômico do pipeline
- `template` - Template para copiar/adaptar
- `example` - Exemplo homologado read-only
- `deliverable` - Entregável gerado por agente
- `glossary` - Glossário de termos
- `guidelines` - Diretrizes e convenções

**version:** SemVer X.Y.Z (ex: 1.0.0)

**role:** Descrição curta do papel (ex: "entry-point", "validation", "reference")

### Campos Opcionais mas Recomendados:

**status:** draft | review | approved | deprecated

**priority:** critical | high | medium | low

**keywords:** Array de palavras-chave para indexação

**consumes:** Array de arquivos que este documento lê/referencia (upstream)

**feeds:** Array de arquivos que este documento alimenta (downstream)

---

## 📝 Seções Obrigatórias em Cada Documento

### 1. Nota de Glossário (imediatamente após o título)
```markdown
> **📖 Termos técnicos:** Consulte [GLOSSARY.md](./GLOSSARY.md) para definições canônicas
```

### 2. Mapa de Dependências (após a nota de glossário)
```markdown
## 🔗 Mapa de Dependências

### ⬆️ Upstream (O que este documento consome)
- **[arquivo.md](./arquivo.md#secao)** - Descrição do que usa
  - *Usa:* Campo X, Protocolo Y
  - *Referência:* Seção "Título da Seção"

### ⬇️ Downstream (O que este documento alimenta)
- **[outro-arquivo.md](./outro-arquivo.md)** - Descrição do que fornece
  - *Fornece:* Estrutura Z, Definição W

### 🔄 Relacionamentos Laterais (opcional)
- **[referencia.md](./referencia.md)** - Documento relacionado
  - *Tipo:* Exemplo paralelo / Alternativa / Contexto histórico
```

**Por que isso é crítico:**
- LLMs podem construir um grafo de dependências mental
- Evita circular dependencies (A → B → A)
- Quando um documento muda, sabemos quais outros revisar
- Facilita navegação programática

---

## 🔗 Convenções de Hyperlinks

### Links Internos

**Com ancoragem (preferido):**
```markdown
[CODEX_TASK.md](./CODEX_TASK.md#workflow-sequencial)
```

**Sem ancoragem (quando referencia documento inteiro):**
```markdown
[GLOSSARY.md](./GLOSSARY.md)
```

### Links Relativos

Sempre use caminhos relativos, não absolutos:

```markdown
✅ Bom: [chunks/00-context.md](./chunks/00-context.md)
❌ Ruim: [chunks/00-context.md](/home/user/project/chunks/00-context.md)
```

**Razão:** Caminhos relativos funcionam independente de onde o repositório está clonado.

### Links para Seções Específicas

Use kebab-case para ancoragem:

```markdown
[Ver Workflow Sequencial](./CODEX_TASK.md#workflow-sequencial)
```

**Regra de conversão:**
- Título: "Workflow Sequencial"
- Âncora: `#workflow-sequencial` (lowercase, espaços viram hífen)

***

## Checklist de Validação Pré-Commit

Antes de fazer commit, verifique:

- [ ] Frontmatter YAML presente e completo
- [ ] Campo `type` está em valores permitidos
- [ ] Campo `version` está no formato SemVer (X.Y.Z)
- [ ] Nota de glossário incluída após título
- [ ] Seção "Mapa de Dependências" presente com Upstream/Downstream
- [ ] Todos os links internos testados e funcionando
- [ ] Nomenclatura de arquivo segue convenção deste guia
- [ ] Versão incrementada corretamente se houver mudanças (ver VERSIONING.md)
- [ ] Script `npm run validate` executado sem erros
- [ ] CHANGELOG.md atualizado (para mudanças significativas)

***

## Scripts de Validação

Execute antes de commit:

```bash
# Validar todos os documentos
npm run validate

# Gerar índice de contexto atualizado
npm run generate-index

# Executar suite completa (validação + geração + testes)
npm run precommit
```

***

## Exemplos Práticos

### Exemplo 1: Criar Novo Chunk

**Cenário:** Você precisa adicionar um chunk sobre tratamento de erros.

**Passos:**

1. Identificar próximo número disponível: `09`
2. Criar arquivo: `chunks/09-error-handling.md`
3. Adicionar frontmatter:

```yaml
---
type: chunk
chunk_number: 09
kit_version: 1.0.0
version: 1.0.0
role: error-handling-strategy
status: draft
keywords: [errors, exceptions, resilience, fallback]
consumes: [chunks/08-validation.md]
feeds: [components/]
---
```

4. Adicionar nota de glossário
5. Adicionar mapa de dependências
6. Escrever conteúdo (máximo 120 linhas)
7. Atualizar CONTEXT_INDEX.json
8. Executar `npm run validate`

***

### Exemplo 2: Migrar Arquivo Ambíguo

**Cenário:** Você tem `feature-recurso-progressbar.md` no root.

**Análise:**
- É um exemplo de outro projeto (mywai)
- Serve como template estrutural
- Não é entregável ativo deste projeto

**Ação:**
```bash
# Criar pasta se não existir
mkdir -p templates/

# Renomear seguindo convenção
mv feature-recurso-progressbar.md templates/mywai-feature-progressbar.md
```

**Atualizar referências:**
Buscar em todos os arquivos .md que referenciam o arquivo antigo:

```bash
grep -r "feature-recurso-progressbar.md" . --include="*.md"
```

Substituir por:
```markdown
[templates/mywai-feature-progressbar.md](./templates/mywai-feature-progressbar.md)
```

***

### Exemplo 3: Promover Entregável de Draft para Approved

**Cenário:** `components/llm-readable-auth-flow-v0.3-review.md` foi aprovado pelo Operador.

**Passos:**

1. Incrementar versão para 1.0 (primeiro approved = major version)
2. Mudar status para `approved`
3. Renomear arquivo:

```bash
mv components/llm-readable-auth-flow-v0.3-review.md \
   components/llm-readable-auth-flow-v1.0-approved.md
```

4. Atualizar frontmatter dentro do arquivo:

```yaml
---
type: deliverable
version: 1.0.0
status: approved
approved_date: 2026-02-15
approved_by: Operador
---
```

5. Registrar em CHANGELOG.md:

```markdown
## [1.0.0] - 2026-02-15

### Added
- Auth Flow framework approved and promoted to v1.0
```

6. Considerar criar exemplo read-only:

```bash
cp components/llm-readable-auth-flow-v1.0-approved.md \
   examples/auth-flow-example-v1.0.md
```

***

## Padrões de Commit

Use Conventional Commits:

```
<tipo>(<escopo>): <descrição curta>

[corpo opcional]

[rodapé opcional]
```

**Tipos:**
- `feat`: Nova funcionalidade
- `fix`: Correção de bug
- `docs`: Mudanças em documentação
- `refactor`: Refatoração sem mudança de funcionalidade
- `chore`: Tarefas de manutenção

**Exemplos:**

```bash
git commit -m "docs(contributing): adiciona convenções de nomenclatura"

git commit -m "feat(chunks): adiciona chunk 09 para error handling"

git commit -m "refactor(components): migra nomenclatura para padrão v1.0"
```

***

## Tratamento de Arquivos Legados

**Cenário:** Você tem arquivos que não seguem nenhuma convenção.

**Estratégia:**

1. Classificar o arquivo:
   - É um protocolo? → `protocols/`
   - É um exemplo? → `templates/` ou `examples/`
   - É um entregável? → `components/`
   - É contexto histórico? → `docs/`

2. Avaliar se deve ser mantido:
   - Ainda é relevante?
   - Há duplicação com documentos novos?
   - Pode ser arquivado?

3. Se manter:
   - Migrar para pasta apropriada
   - Adicionar frontmatter YAML
   - Adicionar mapa de dependências
   - Atualizar referências

4. Se arquivar:
   ```bash
   mkdir -p docs/archive/
   mv arquivo-legado.md docs/archive/
   ```

5. Documentar decisão em CHANGELOG.md

***

## FAQ - Perguntas Frequentes

### Q: Quando devo criar um novo chunk vs adicionar a um existente?

**R:** Crie novo chunk quando:
- O conteúdo tem uma preocupação distinta
- O chunk atual está próximo de 120 linhas
- Você quer permitir carga seletiva dessa funcionalidade

Adicione a existente quando:
- É detalhamento direto do tópico atual
- Criar separado quebraria coesão lógica

***

### Q: Devo versionar chunks individualmente?

**R:** Sim e não:
- Chunks têm `chunk_version` individual no frontmatter
- Mas também carregam `kit_version` coletiva
- Use `chunk_version` para tracking interno
- Use `kit_version` para compatibilidade com outros componentes

***

### Q: Como lidar com breaking changes em protocolos?

**R:** 
1. Criar novo arquivo com versão major incrementada
2. Manter arquivo antigo por 1 ciclo de release
3. Marcar arquivo antigo como deprecated no frontmatter
4. Atualizar CHANGELOG.md explicando a mudança
5. Avisar no README.md sobre descontinuação

Exemplo:
```bash
# Versão antiga (manter temporariamente)
protocols/fundation-agent-protocol-v1.0.md  # status: deprecated

# Nova versão
protocols/fundation-agent-protocol-v2.0.md  # status: approved
```

***

### Q: Posso ter múltiplas versões de um entregável em components/?

**R:** Sim, mas:
- Apenas 1 deve estar com status `approved` por vez
- Versões antigas aprovadas devem ir para `components/archive/`
- Drafts e reviews podem coexistir durante iteração

Exemplo válido:
```
components/
├── llm-readable-auth-flow-v2.0-approved.md    (versão atual)
├── llm-readable-auth-flow-v2.1-draft.md       (próxima iteração)
└── archive/
    └── llm-readable-auth-flow-v1.0-approved.md (versão anterior)
```

***

### Q: Quando usar templates/ vs examples/?

**R:**

**Use templates/** quando:
- Quer que outros copiem e adaptem
- É estrutura genérica reutilizável
- Vem de outro projeto como referência

**Use examples/** quando:
- É caso de uso específico completo
- Serve como "gold standard" read-only
- Foi aprovado e homologado pelo Operador

**Pode ter ambos:**
```
templates/generic-feature-template.md  (estrutura para copiar)
examples/semantic-export-example-v1.0.md  (implementação real aprovada)
```

***

## Contato e Suporte

Para dúvidas sobre convenções:
1. Consulte este documento (CONTRIBUTING.md)
2. Veja exemplos em `examples/`
3. Execute `npm run validate` para diagnóstico automático
4. Revise `GLOSSARY.md` para terminologia
5. Consulte `VERSIONING.md` para questões de versionamento

***

## Histórico de Mudanças deste Documento

| Versão | Data | Mudanças |
|--------|------|----------|
| 1.0.0 | 2026-02-15 | Versão inicial com convenções completas |
```

---

**ENTREGÁVEL 1 DE 13 COMPLETO**
Aguardando liberação do Operador para prosseguir com o Entregável 2 de 13.
