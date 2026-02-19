# CHUNKIT_TASK — Entry Point para Chunkit Core

**ID Mestre:** 180226-234000
**Data:** 2026-02-18
**Tipo:** Entry point canônico para chunkit-core
**Correlação:** [`aiob3/llm-readable-kit`](https://github.com/aiob3/llm-readable-kit)

---

## Objetivo

Aplicar o **Fundation Agent protocol** adaptado para gerar chunks de projeto estruturados. O chunkit-core produz documentação estruturada que converte conhecimento tácito de arquitetura e governança de projetos em artefatos de chunks replicáveis e idempotentes.

**Entrega obrigatória:** O resultado é depositado na pasta `chunkit-output/` para revisão final do Operador (HITL). O Operador é o **único** que determina se a execução foi bem-sucedida ou se necessita de inferência / iteração / refatoração. Nenhum entregável é considerado aprovado até validação explícita do Operador.

---

## Diferença: Feature-centric vs Project-centric

| Aspecto           | llm-readable-kit (feature-centric)                      | chunkit-core (project-centric)                                  |
| ----------------- | ------------------------------------------------------- | --------------------------------------------------------------- |
| **Unidade base**  | `skill.md` — uma feature de codebase                    | `chunkit.skill.md` — um chunk de projeto (fase/artefato/padrão) |
| **Pipeline**      | Ingestão → Enriquecimento → Projeção → Entrega          | Intake → Derivação → Síntese → Entrega                          |
| **Output**        | Feature Spec + Snippet Técnico + Guia de Adoção         | Chunk Spec + Schema/Assinatura + Guia de Uso                    |
| **Foco**          | Transformar código de feature em framework replicável   | Transformar fases/padrões de projeto em governança rastreável   |
| **Validação**     | Score L0-L5 ≥ 80/100 + HITL                             | Score L0-L5 ≥ 80/100 + HITL                                     |
| **Idempotência**  | Mesmo input + protocolo → mesmo skill.md                | Mesmos parâmetros + protocolo → mesmos chunks                   |

---

## Variáveis de Input (operador preenche antes de acionar)

```text
PROJECT_NAME       = <preenchido pelo operador>
CHUNK_TYPE         = <blueprint | reference | scaffold | validation>
CHUNK_SCOPE        = <fase-específica | cross-fase | arquitetural>
TARGET_ARTIFACTS   = <lista de artefatos que este chunk governa>
VALIDATION_COMMAND = <comando para validar chunk, se aplicável>
OUTPUT_DIR         = chunkit-output/                              # default (não alterar)
```

**Exemplo preenchido (Blueprint de fase CAF — primeiro entregável):**

```text
PROJECT_NAME       = meu-projeto-saas
CHUNK_TYPE         = blueprint
CHUNK_SCOPE        = fase-caf-discovery
TARGET_ARTIFACTS   = requirements.md, stakeholder-map.md, risk-register.md
VALIDATION_COMMAND = ./scripts/validate-caf-discovery.sh
OUTPUT_DIR         = chunkit-output/
```

---

## Workflow Sequencial

1. **Ler protocolo base:** `docs-copy/fundation-agent.prompt.md` (reutilizar o protocolo do llm-readable-kit)
2. **Ler exemplo estrutural:** `docs-copy/components/llm-readable.semantic-export.skill.md` (referência de formato)
3. **Definir chunk target:** identificar tipo (blueprint/reference/scaffold/validation) e escopo (fase/cross-fase)
4. **Executar pipeline adaptado:**
   - **Intake (6 campos):** Nome, Tipo, Escopo, Propósito, Dependências, Critérios de aceite
   - **Derivação:** Meios necessários para operacionalizar o chunk (≥3)
   - **Síntese:** Insights sobre governança e rastreabilidade (≥3)
   - **Tríade adaptada:**
     - **Chunk Spec** — o que é → por que existe → quando usar → critérios de aceite
     - **Schema/Assinatura** — estrutura do chunk (campos obrigatórios, formato, convenções)
     - **Guia de Uso** — como instanciar → como validar → troubleshooting
5. **Gerar output:** salvar em `chunkit-output/chunkit.<CHUNK_TYPE>-<CHUNK_SCOPE>.skill.md`
6. **Validar:** rodar `VALIDATION_COMMAND` + scoring L0-L5 (≥ 80/100)
7. **Depositar para revisão HITL:** o entregável em `chunkit-output/` fica em estado **PENDENTE** até aprovação explícita do Operador
8. **Registrar:** atualizar metadata de projeto (ex: `convergence-metadata.yml`)

### Gate HITL (Human-in-the-Loop)

Após o passo 7, o agente **para e aguarda**. O Operador revisa o entregável em `chunkit-output/` e decide:

| Decisão do Operador        | Ação                                                           |
| -------------------------- | -------------------------------------------------------------- |
| **Aprovado**               | Chunk é promovido (commit + indexação em metadata)             |
| **Inferência necessária**  | Operador indica gaps; agente retorna ao passo 4 com ajustes    |
| **Iteração necessária**    | Operador pede reexecução parcial; agente refaz                 |
| **Refatoração necessária** | Operador indica reestruturação; agente revisa desde o passo 3  |

---

## Tipos de Chunks (taxonomia do chunkit-core)

| Tipo          | Propósito                                                            | Exemplo                           |
| ------------- | -------------------------------------------------------------------- | --------------------------------- |
| **blueprint** | Define estrutura e governança de uma fase de projeto                 | `blueprint-caf-discovery.skill`   |
| **reference** | Documenta padrões, convenções e decisões arquiteturais               | `reference-api-patterns.skill`    |
| **scaffold**  | Fornece templates e código boilerplate reutilizável                  | `scaffold-nextjs-app.skill`       |
| **validation**| Define critérios de aceite, checklists e gates de qualidade          | `validation-security-gates.skill` |

---

## Mapa de Chunks Reutilizáveis (do llm-readable-kit)

O chunkit-core **reutiliza** os chunks conceituais do llm-readable-kit, mas adapta o pipeline para o contexto project-centric:

### Entender o pipeline completo do chunkit

Carregar do llm-readable-kit: `00-context` + `01-files` + `04-project` + `05-deliver` + `08-validation`

### Criar novo tipo de chunk

Carregar: `06-lookup-tables` + `07-invariants` + `08-validation`

### Validar chunk existente

Carregar: `07-invariants` + `08-validation`

### Estender taxonomia de chunks

Carregar: `06-lookup-tables` + `07-invariants`

---

## Critérios "Done"

- [ ] Documento `chunkit.<CHUNK_TYPE>-<CHUNK_SCOPE>.skill.md` criado
- [ ] Intake preenchido (6/6 campos: Nome, Tipo, Escopo, Propósito, Dependências, Critérios)
- [ ] Meios necessários mapeados (≥3)
- [ ] Insights de governança extraídos (≥3)
- [ ] Tríade completa (Chunk Spec + Schema/Assinatura + Guia de Uso)
- [ ] Lookup tables adaptadas para domínio do chunk (se aplicável)
- [ ] Invariantes documentadas (contratos que o chunk deve respeitar)
- [ ] Score ≥ 80/100 na auto-avaliação logarítmica (L0-L5)
- [ ] Validação executada: `VALIDATION_COMMAND` → PASS (se aplicável)
- [ ] Entregável depositado em `chunkit-output/` para revisão
- [ ] **Aprovação HITL recebida** (Operador validou o entregável)
- [ ] Metadata atualizada (convergence-metadata.yml ou equivalente)

---

## Padrão Arquitetural: Grafo de Chunks + Governança

O chunkit-core segue o padrão de **grafo de chunks com governança de execução**:

```
Intake    → Chunk descriptor (tipo, escopo, propósito, dependências)
Derivação → Meios necessários (ferramentas, padrões, templates)
Síntese   → Insights de governança (por que, como, quando, limites)
Entrega   → chunkit.skill.md (Spec + Schema + Guia)
```

### Princípios de Atomicidade (herdados do llm-readable-kit)

1. **Idempotência**: Mesmos inputs → mesmos outputs
2. **Rastreabilidade**: ID Mestre + tags + cross-references
3. **Validação determinística**: Score L0-L5 + testes automatizados
4. **HITL obrigatório**: Nenhum chunk é auto-aprovado
5. **Desacoplamento**: Chunks são autocontidos e não dependem de implementações específicas de outros projetos

---

## Correlação com llm-readable-kit

O chunkit-core adota o llm-readable-kit como:

- **Dependência estrutural**: Formato `skill.md`, protocolo Fundation Agent, scoring L0-L5
- **Dependência conceitual**: Pipeline de camadas, HITL gates, idempotência operacional
- **Não-dependência de código**: Não importa código ou features específicas; apenas o modelo operacional

### Boundary Explícito

```
llm-readable-kit → [modelo operacional] → chunkit-core
      ↓                                        ↓
   skill.md                              chunkit.skill.md
  (features)                           (chunks de projeto)
```

---

## Exemplo de Uso

### Caso 1: Criar blueprint de fase CAF Discovery

```bash
# 1. Preencher variáveis no CHUNKIT_TASK.md
PROJECT_NAME       = meu-projeto-saas
CHUNK_TYPE         = blueprint
CHUNK_SCOPE        = fase-caf-discovery
TARGET_ARTIFACTS   = requirements.md, stakeholder-map.md, risk-register.md
VALIDATION_COMMAND = ./scripts/validate-caf-discovery.sh

# 2. Agente executa pipeline e gera:
# chunkit-output/chunkit.blueprint-caf-discovery.skill.md

# 3. Operador revisa e aprova (HITL)
```

### Caso 2: Criar scaffold de aplicação Next.js

```bash
PROJECT_NAME       = startup-mvp
CHUNK_TYPE         = scaffold
CHUNK_SCOPE        = nextjs-app-structure
TARGET_ARTIFACTS   = app/, components/, lib/, public/
VALIDATION_COMMAND = npm run build && npm run test

# Gera: chunkit-output/chunkit.scaffold-nextjs-app-structure.skill.md
```

---

## Inventário do Chunkit Kit

| Arquivo                       | Papel                                         | Leitura     |
| ----------------------------- | --------------------------------------------- | ----------- |
| `CHUNKIT_TASK.md`             | Entry point (este arquivo)                    | Obrigatória |
| `docs-copy/`                  | Kit llm-readable-kit reutilizado              | Referência  |
| `chunkit-output/`             | Repositório de chunks gerados (revisão HITL)  | Output      |
| `convergence-metadata.yml`    | Metadata de grafo de chunks (futuro)          | Opcional    |

---

## Primeiro Entregável (validação do kit)

O primeiro chunk deve ser um **meta-chunk**: a documentação do próprio chunkit-core no formato `chunkit.skill.md`, provando que o kit é **auto-suficiente** e capaz de documentar a si mesmo usando o protocolo herdado do llm-readable-kit.

Este entregável será: `chunkit-output/chunkit.reference-chunkit-core.skill.md`
