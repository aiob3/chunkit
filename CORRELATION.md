# Correlação: chunkit-core ↔ llm-readable-kit

**ID:** 180226-234000
**Propósito:** Documentar boundary e dependências entre os dois kits complementares

---

## Visão Geral

Este documento formaliza a correlação entre **chunkit-core** (project-centric) e **llm-readable-kit** (feature-centric), ambos baseados no protocolo Fundation Agent mas aplicados a contextos distintos.

---

## Mapeamento 1:1

| Conceito                   | llm-readable-kit                      | chunkit-core                              |
| -------------------------- | ------------------------------------- | ----------------------------------------- |
| **Entry point**            | `docs-copy/CODEX_TASK.md`             | `CHUNKIT_TASK.md`                         |
| **Unidade atômica**        | `skill.md` (feature)                  | `chunkit.skill.md` (chunk de projeto)     |
| **Pasta de entrega**       | `docs-copy/components/`               | `chunkit-output/`                         |
| **Pipeline**               | Ingestão→Enriquecimento→Projeção→Entrega | Intake→Derivação→Síntese→Entrega       |
| **Tríade**                 | Feature Spec + Snippet + Guia         | Chunk Spec + Schema + Guia                |
| **Validação**              | Score L0-L5 ≥ 80/100 + HITL           | Score L0-L5 ≥ 80/100 + HITL               |
| **Protocolo de execução**  | `fundation-agent.prompt.md`           | Reutilizado do llm-readable-kit           |
| **Idempotência**           | Copy/paste `docs-copy/` + vars        | Usar `CHUNKIT_TASK.md` + vars             |
| **Taxonomia de saída**     | `llm-readable.<feature>.skill.md`     | `chunkit.<tipo>-<escopo>.skill.md`        |
| **ID Mestre**              | `DDMMYY-HHMMSS` (GMT-3)               | `DDMMYY-HHMMSS` (GMT-3)                   |

---

## Diferenças (Feature-centric vs Project-centric)

### Foco

- **llm-readable-kit:** Documenta **como uma feature de código funciona** (ex: SemanticExport, ProgressBar)
- **chunkit-core:** Documenta **como uma fase/padrão de projeto se estrutura** (ex: CAF Discovery, API Patterns)

### Insumos

- **llm-readable-kit:** Código-fonte (arquivos .js, .py, etc.) + testes + entry points
- **chunkit-core:** Artefatos de projeto (blueprints, ADRs, checklists) + metadata de governança

### Outputs

- **llm-readable-kit:** Feature Spec (problema técnico) + Snippet (implementação) + Guia (como usar a feature)
- **chunkit-core:** Chunk Spec (propósito do chunk) + Schema (estrutura) + Guia (como instanciar o chunk)

### Tipos de Unidades

- **llm-readable-kit:** Não tem tipologia explícita — toda feature vira um skill.md
- **chunkit-core:** 4 tipos primários — blueprint | reference | scaffold | validation

---

## Dependências

### Dependência Estrutural (chunkit-core → llm-readable-kit)

O chunkit-core **reutiliza** do llm-readable-kit:

1. ✅ **Formato skill.md** — estrutura de seções (Intake, Meios, Insights, Tríade, Metadata, Scoring, HITL)
2. ✅ **Protocolo Fundation Agent** — loop metacognitivo recursivo (`docs-copy/fundation-agent.prompt.md`)
3. ✅ **Sistema de scoring L0-L5** — validação logarítmica com mínimo 80/100
4. ✅ **Gate HITL** — aprovação humana obrigatória, nunca auto-aprovação
5. ✅ **Idempotência operacional** — mesmas variáveis + protocolo → mesmo output

### Não-Dependência (boundary explícito)

O chunkit-core **NÃO depende** de:

1. ❌ Implementações específicas de features (SemanticExport, ProgressBar, etc.)
2. ❌ Código executável do llm-readable-kit
3. ❌ Detalhes de stacks tecnológicos (JavaScript, Node.js, etc.) do llm-readable-kit
4. ❌ Artefatos concretos gerados pelo llm-readable-kit (`components/*.skill.md`)

### Boundary Diagram

```
┌──────────────────────────────────────────────┐
│        llm-readable-kit (upstream)           │
│  ┌────────────────────────────────────────┐  │
│  │  Modelo Operacional (REUTILIZÁVEL)     │  │
│  │  - skill.md format                     │  │
│  │  - Fundation Agent protocol            │  │
│  │  - HITL + scoring L0-L5                │  │
│  │  - Idempotência via templates          │  │
│  └────────────────────────────────────────┘  │
│         ↓ (dependência estrutural)           │
│  ┌────────────────────────────────────────┐  │
│  │  Features Específicas (ISOLADAS)       │  │
│  │  - SemanticExport                      │  │
│  │  - ProgressBar                         │  │
│  │  - [código JavaScript específico]      │  │
│  └────────────────────────────────────────┘  │
└──────────────────────────────────────────────┘
                    ↓
         (adota modelo operacional)
                    ↓
┌──────────────────────────────────────────────┐
│        chunkit-core (downstream)             │
│  ┌────────────────────────────────────────┐  │
│  │  Modelo Adaptado (project-centric)     │  │
│  │  - chunkit.skill.md format             │  │
│  │  - Pipeline: Intake→Derivação→Síntese  │  │
│  │  - HITL + scoring (mesmo L0-L5)        │  │
│  │  - Taxonomia de chunks (4 tipos)       │  │
│  └────────────────────────────────────────┘  │
│         ↓ (gera)                             │
│  ┌────────────────────────────────────────┐  │
│  │  Chunks de Projeto (OUTPUTS)           │  │
│  │  - blueprints (fases CAF, etc.)        │  │
│  │  - references (padrões arquiteturais)  │  │
│  │  - scaffolds (templates de código)     │  │
│  │  - validations (gates de qualidade)    │  │
│  └────────────────────────────────────────┘  │
└──────────────────────────────────────────────┘
```

**Regra de ouro:**
> "O chunkit-core adota o **como fazer** do llm-readable-kit, não o **o que fazer**."

---

## Workflow de Integração

### Para Operador

1. **Usar llm-readable-kit** quando precisar documentar uma feature de codebase:
   ```bash
   cd docs-copy/
   # Editar CODEX_TASK.md com FEATURE_NAME, ENTRY_POINTS, etc.
   # Acionar agente
   # Output: docs-copy/components/llm-readable.<feature>.skill.md
   ```

2. **Usar chunkit-core** quando precisar documentar governança de projeto:
   ```bash
   # Editar CHUNKIT_TASK.md com PROJECT_NAME, CHUNK_TYPE, CHUNK_SCOPE, etc.
   # Acionar agente
   # Output: chunkit-output/chunkit.<tipo>-<escopo>.skill.md
   ```

### Para Agentes

- Ao ser acionado via `docs-copy/CODEX_TASK.md` → aplicar pipeline feature-centric
- Ao ser acionado via `CHUNKIT_TASK.md` → aplicar pipeline project-centric
- Em ambos os casos: executar scoring L0-L5 + aguardar gate HITL

---

## Princípios de Atomicidade (herdados e reforçados)

1. **Idempotência:** Mesmos inputs + mesmo protocolo → mesmos outputs
2. **Rastreabilidade:** ID Mestre obrigatório + tags + cross-references
3. **Validação determinística:** Score L0-L5 + testes automatizados (quando aplicável)
4. **HITL obrigatório:** Nenhum artefato é auto-aprovado
5. **Desacoplamento:** Dependências estruturais (modelo operacional) apenas; nunca dependências de código específico
6. **Portabilidade:** Kits são copy/paste-able; zero setup externo necessário

---

## Casos de Uso

### Caso 1: Documentar Feature de Código

**Situação:** Preciso documentar como funciona o sistema de autenticação JWT do meu projeto.

**Kit:** llm-readable-kit

**Entrada:**
```yaml
FEATURE_NAME    = jwt-authentication
CODEBASE_PATH   = src/auth/
ENTRY_POINTS    = src/auth/JWTService.ts, src/middleware/authMiddleware.ts
TEST_FILE       = tests/auth/jwt.test.ts
TEST_COMMAND    = npm test -- jwt.test.ts
```

**Saída:** `docs-copy/components/llm-readable.jwt-authentication.skill.md`

---

### Caso 2: Documentar Blueprint de Fase CAF

**Situação:** Preciso padronizar a fase de Discovery do Cloud Adoption Framework para replicar em vários projetos.

**Kit:** chunkit-core

**Entrada:**
```yaml
PROJECT_NAME       = template-caf-discovery
CHUNK_TYPE         = blueprint
CHUNK_SCOPE        = fase-caf-discovery
TARGET_ARTIFACTS   = requirements.md, stakeholder-map.md, risk-register.md, cost-estimate.xlsx
VALIDATION_COMMAND = ./scripts/validate-caf-discovery.sh
```

**Saída:** `chunkit-output/chunkit.blueprint-caf-discovery.skill.md`

---

### Caso 3: Documentar Padrão Arquitetural

**Situação:** Preciso documentar as convenções de API REST que todos os serviços do projeto devem seguir.

**Kit:** chunkit-core

**Entrada:**
```yaml
PROJECT_NAME       = api-standards
CHUNK_TYPE         = reference
CHUNK_SCOPE        = cross-fase
TARGET_ARTIFACTS   = api-conventions.md, openapi-template.yml
VALIDATION_COMMAND = spectral lint openapi-template.yml
```

**Saída:** `chunkit-output/chunkit.reference-api-standards.skill.md`

---

### Caso 4: Documentar Scaffold de Aplicação

**Situação:** Preciso criar um template de projeto Next.js + TypeScript + Tailwind que todos os novos projetos devem usar.

**Kit:** chunkit-core

**Entrada:**
```yaml
PROJECT_NAME       = nextjs-starter
CHUNK_TYPE         = scaffold
CHUNK_SCOPE        = arquitetural
TARGET_ARTIFACTS   = app/, components/, lib/, tsconfig.json, tailwind.config.js
VALIDATION_COMMAND = npm run build && npm run test
```

**Saída:** `chunkit-output/chunkit.scaffold-nextjs-starter.skill.md`

---

## Convergência

Ambos os kits convergem em:

- **Formato final:** `skill.md` com tríade obrigatória
- **Validação:** Score L0-L5 ≥ 80/100
- **Aprovação:** Gate HITL (nunca auto-aprovação)
- **Rastreabilidade:** ID Mestre + tags + cross-references
- **Idempotência:** Inputs determinísticos → outputs determinísticos
- **Portabilidade:** Copy/paste-able sem setup externo

A diferença está no **foco** (features vs chunks) e na **taxonomia** (único tipo vs 4 tipos), mas o **modelo operacional** é compartilhado.

---

## Referências

- **llm-readable-kit:** [`aiob3/llm-readable-kit`](https://github.com/aiob3/llm-readable-kit)
- **Protocolo Fundation Agent:** `docs-copy/fundation-agent.prompt.md`
- **Exemplo canônico:** `docs-copy/components/llm-readable.semantic-export.skill.md`
- **Template chunkit:** `chunkit-output/TEMPLATE.chunkit.skill.md`
- **Meta-chunk:** `chunkit-output/chunkit.reference-chunkit-core.skill.md`

---

**Fim do documento.**
