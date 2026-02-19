# Chunkit — Kit de Documentação Estruturada para Projetos e Features

**ID Mestre:** 180226-234000
**Correlação:** [`aiob3/llm-readable-kit`](https://github.com/aiob3/llm-readable-kit)

Este repositório integra dois kits complementares de extração de conhecimento:

1. **llm-readable-kit** (feature-centric) — Transforma conhecimento tácito de **features de codebase** em documentação estruturada
2. **chunkit-core** (project-centric) — Transforma conhecimento de **governança e arquitetura de projetos** em chunks rastreáveis

Ambos usam o protocolo **Fundation Agent** — um loop metacognitivo recursivo que gera artefatos padronizados com validação HITL (Human-in-the-Loop) obrigatória.

---

## Quick Start

### Para Feature-Centric (llm-readable-kit)

```bash
# 1. Copie a pasta docs-copy/ para o seu projeto
cp -r docs-copy/ /caminho/do/seu/projeto/docs-copy/

# 2. Preencha as variáveis em docs-copy/CODEX_TASK.md
#    FEATURE_NAME, CODEBASE_PATH, ENTRY_POINTS, TEST_FILE, TEST_COMMAND

# 3. Acione o agente com docs-copy/CODEX_TASK.md como entry point
```

### Para Project-Centric (chunkit-core)

```bash
# 1. Use CHUNKIT_TASK.md como entry point
# 2. Preencha as variáveis:
#    PROJECT_NAME, CHUNK_TYPE, CHUNK_SCOPE, TARGET_ARTIFACTS, VALIDATION_COMMAND

# 3. Agente gera chunks em chunkit-output/
# 4. Operador revisa e aprova (HITL gate)
```

## Scripts de Automação

O chunkit-core fornece 4 scripts para operacionalizar o workflow:

| Script | Propósito | Uso |
|--------|-----------|-----|
| `scripts/new_chunk.sh` | Criar novo chunk a partir de template | `./scripts/new_chunk.sh blueprint caf-discovery` |
| `scripts/update_metadata.sh` | Sincronizar convergence-metadata.yml | `./scripts/update_metadata.sh` |
| `scripts/validate_chunk.sh` | Validar chunk (score L0-L5) | `./scripts/validate_chunk.sh chunkit-output/chunkit.reference-*.skill.md` |
| `scripts/promote_chunk.sh` | Promover chunk pós-HITL | `./scripts/promote_chunk.sh chunkit-output/chunkit.reference-*.skill.md` |

### Workflow Completo

```bash
# 1. Criar novo chunk
./scripts/new_chunk.sh blueprint caf-discovery

# 2. Editar arquivo gerado (preencher Intake, Meios, Insights, Tríade)
# chunkit-output/chunkit.blueprint-caf-discovery.skill.md

# 3. Validar chunk
./scripts/validate_chunk.sh chunkit-output/chunkit.blueprint-caf-discovery.skill.md
# Score: 85/100 | Status: APROVADO

# 4. Revisão HITL (operador valida manualmente)
# Atualizar `Status: APROVADO` no arquivo .skill.md

# 5. Promover chunk
./scripts/promote_chunk.sh chunkit-output/chunkit.blueprint-caf-discovery.skill.md
# ✓ Chunk promovido | Commit: a1b2c3d
```

## O que é

Este repositório **não é um projeto de aplicação** — é um sistema dual de documentação/extração:

### llm-readable-kit (Feature-Centric)

Para documentar **features de codebase**:

1. **Recebe** a indicação de uma feature + acesso ao codebase
2. **Executa** pipeline de 4 camadas (Ingestão → Enriquecimento → Projeção → Entrega)
3. **Produz** um `skill.md` com tríade obrigatória:
   - **Feature Spec** — problema → solução → fluxo → critérios de aceite
   - **Snippet Técnico** — assinatura + pseudocódigo + código real + grafo de dependências
   - **Guia de Adoção** — pré-requisitos + passos + testes + troubleshooting
4. **Valida** via scoring logarítmico L0-L5 (mínimo 80/100)
5. **Aguarda** aprovação HITL — nunca auto-aprova

### chunkit-core (Project-Centric)

Para documentar **chunks de governança e arquitetura de projetos**:

1. **Recebe** tipo de chunk (blueprint/reference/scaffold/validation) + escopo do projeto
2. **Executa** pipeline adaptado (Intake → Derivação → Síntese → Entrega)
3. **Produz** um `chunkit.skill.md` com tríade adaptada:
   - **Chunk Spec** — o que é → por que existe → quando usar → critérios
   - **Schema/Assinatura** — estrutura e convenções do chunk
   - **Guia de Uso** — como instanciar → como validar → troubleshooting
4. **Valida** via scoring L0-L5 (mínimo 80/100)
5. **Aguarda** aprovação HITL — nunca auto-aprova

## Estrutura do Repositório

```
chunkit/
├── CHUNKIT_TASK.md                ← Entry point para chunkit-core (project-centric)
├── chunkit-output/                ← Chunks de projeto gerados (HITL pendente)
│   ├── README.md
│   ├── TEMPLATE.chunkit.skill.md
│   └── chunkit.reference-chunkit-core.skill.md  ← Primeiro entregável
│
├── docs-copy/                     ← Kit llm-readable (feature-centric) — COPIÁVEL
│   ├── CODEX_TASK.md              ← Entry point para llm-readable-kit
│   ├── fundation-agent.prompt.md  ← Protocolo Fundation Agent (compartilhado)
│   ├── feature-recurso-progressbar.md ← Referência estrutural
│   ├── framework-llm-readable.semantic-export.md ← Exemplo completo
│   ├── chunks/00..08-*.md         ← Instruções atômicas (carregar seletivamente)
│   ├── components/                ← Features documentadas (HITL aprovado)
│   │   ├── llm-readable.semantic-export.skill.md
│   │   └── llm-readable.progress-bar-1-a-1.skill.md
│   ├── samples/                   ← Amostras de dados
│   └── reference_study_sop.md     ← Contexto histórico
│
├── [arquivos de raiz — referência ao llm-readable-kit original]
├── CODEX_TASK.md
├── fundation-agent.prompt.md
├── chunks/
└── components/
```

### Dualidade dos Kits

| Aspecto       | llm-readable-kit (`docs-copy/`)       | chunkit-core (raiz)                       |
| ------------- | ------------------------------------- | ----------------------------------------- |
| **Foco**      | Features de codebase                  | Chunks de projeto (fases, padrões, gates)|
| **Entry**     | `docs-copy/CODEX_TASK.md`             | `CHUNKIT_TASK.md`                         |
| **Output**    | `docs-copy/components/*.skill.md`     | `chunkit-output/*.skill.md`               |
| **Pipeline**  | Ingestão→Enriquecimento→Projeção      | Intake→Derivação→Síntese                  |
| **Portável**  | Sim (copiar docs-copy/)               | Sim (copiar estrutura chunkit/)           |

## Entregáveis Produzidos

### Features (llm-readable-kit)

| Feature                             | Arquivo                                               | Status   |
| ----------------------------------- | ----------------------------------------------------- | -------- |
| Semantic Export (Visual→LLM Bridge) | `components/llm-readable.semantic-export.skill.md`    | Aprovado |
| Progress Bar 1-a-1 (FFmpeg)         | `components/llm-readable.progress-bar-1-a-1.skill.md` | Aprovado |

### Chunks (chunkit-core)

| Chunk                          | Arquivo                                               | Status   |
| ------------------------------ | ----------------------------------------------------- | -------- |
| Chunkit Core Reference         | `chunkit-output/chunkit.reference-chunkit-core.skill.md` | Pendente HITL |

## Para Agentes AI

Ler `.github/copilot-instructions.md` para convenções gerais.

**Entry points:**
- **Feature-centric:** `docs-copy/CODEX_TASK.md` (documentar features de codebase)
- **Project-centric:** `CHUNKIT_TASK.md` (documentar chunks de projeto)

## Autor

brito@vcia.com.br   |   linkedin.com/in/brito1   |    indygolab.com

## Licença

[MIT](LICENSE)
