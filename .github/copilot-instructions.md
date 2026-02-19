# Copilot Instructions — Chunkit (Fundation Agent Kit)

**ID Mestre:** 180226-234000
**Correlação:** [`aiob3/llm-readable-kit`](https://github.com/aiob3/llm-readable-kit)

## Propósito do Repositório

Este é um repositório **dual** que integra dois kits complementares:

1. **llm-readable-kit** (feature-centric) — Kit portável de extração de frameworks LLM-readable (ID Mestre: 060226-191500). Transforma conhecimento tácito de **features de codebase** em documentação estruturada e replicável.

2. **chunkit-core** (project-centric) — Kit de governança de chunks de projeto. Transforma conhecimento de **arquitetura e fases de projetos** em chunks estruturados e rastreáveis.

Ambos usam o protocolo **Fundation Agent** com loop metacognitivo recursivo.

**Não é um projeto de aplicação** — é um sistema de documentação/extração que gera artefatos em:
- `docs-copy/components/` (features)
- `chunkit-output/` (chunks de projeto)

## Estrutura e Navegação

### Entry Points (escolher conforme contexto)

1. **Para documentar features de codebase:** `docs-copy/CODEX_TASK.md` (feature-centric)
2. **Para documentar chunks de projeto:** `CHUNKIT_TASK.md` (project-centric)

### Estrutura Completa

```
chunkit/
├── CHUNKIT_TASK.md                ← Entry point para chunkit-core (project-centric)
├── CORRELATION.md                 ← Boundary e dependências entre os dois kits
├── chunkit-output/                ← Chunks de projeto gerados (HITL pendente)
│   ├── README.md
│   ├── TEMPLATE.chunkit.skill.md
│   └── chunkit.reference-chunkit-core.skill.md
│
├── docs-copy/                     ← Kit llm-readable (feature-centric) — COPIÁVEL
│   ├── CODEX_TASK.md              ← Entry point para llm-readable-kit
│   ├── fundation-agent.prompt.md  ← Protocolo Fundation Agent (compartilhado)
│   ├── feature-recurso-progressbar.md ← Referência estrutural
│   ├── framework-llm-readable.semantic-export.md ← Exemplo completo
│   ├── chunks/00..08-*.md         ← Instruções atômicas (carregar seletivamente)
│   ├── components/                ← Features documentadas (HITL aprovado)
│   ├── samples/                   ← Amostras de dados
│   └── reference_study_sop.md     ← Contexto histórico
│
└── [arquivos de raiz — referência ao llm-readable-kit original]
```

### Regra de carregamento de chunks

Não carregar todos os chunks sempre. Usar o mapa em `docs-copy/CODEX_TASK.md` seção "Mapa de Chunks por Tipo de Tarefa":

- **Pipeline completo**: `00-context` + `01-files` + `02-ingest` + `03-enrich` + `04-project` + `05-deliver`
- **Novo formato de projeção**: `04-project` + `06-lookup-tables` + `07-invariants`
- **Validar implementação**: `01-files` + `07-invariants` + `08-validation`
- **Replicar para outro projeto**: todos + `fundation-agent.prompt.md`

## Workflow Obrigatório

### Para Feature-Centric (llm-readable-kit)

1. Operador copia `docs-copy/` para o projeto-alvo e preenche variáveis em `docs-copy/CODEX_TASK.md` (`FEATURE_NAME`, `CODEBASE_PATH`, `ENTRY_POINTS`, etc.)
2. Agente lê `docs-copy/CODEX_TASK.md` como entry point
3. Agente executa pipeline: Intake (6 campos) → Derivação (meios) → Insights (≥3) → Tríade (Feature Spec + Snippet + Guia)
4. Output salvo em `docs-copy/components/llm-readable.<FEATURE_NAME>.skill.md`
5. **Gate HITL**: agente PARA e aguarda aprovação do Operador — nunca auto-aprovar
6. Scoring L0-L5 ≥ 80/100 obrigatório antes de depositar

### Para Project-Centric (chunkit-core)

1. Operador preenche variáveis em `CHUNKIT_TASK.md` (`PROJECT_NAME`, `CHUNK_TYPE`, `CHUNK_SCOPE`, `TARGET_ARTIFACTS`, etc.)
2. Agente lê `CHUNKIT_TASK.md` como entry point
3. Agente executa pipeline adaptado: Intake (6 campos) → Derivação (meios) → Síntese (insights de governança ≥3) → Tríade (Chunk Spec + Schema + Guia)
4. Output salvo em `chunkit-output/chunkit.<CHUNK_TYPE>-<CHUNK_SCOPE>.skill.md`
5. **Gate HITL**: agente PARA e aguarda aprovação do Operador — nunca auto-aprovar
6. Scoring L0-L5 ≥ 80/100 obrigatório antes de depositar

## Convenções Críticas

### Nomenclatura de arquivos

**llm-readable-kit:**
- Entregáveis: `llm-readable.<feature-kebab>.skill.md` (dentro de `docs-copy/components/`)
- Chunks instrucionais: `docs-copy/chunks/NN-<preocupação>.md` (numeração sequencial, 00-08)

**chunkit-core:**
- Entregáveis: `chunkit.<tipo>-<escopo-kebab>.skill.md` (dentro de `chunkit-output/`)
- Tipos: `blueprint` | `reference` | `scaffold` | `validation`

### Idioma

- Toda documentação e terminologia em **PT-BR**
- Código de referência e pseudocódigo podem usar inglês

### ID Mestre

- Aplicar `DDMMYY-HHMMSS` em todo documento gerado ou bloco significativo. O ID Mestre do kit é `060226-191500`.
- Formato: `DDMMYY-HHMMSS` (Dia, Mês, Ano, Hora, Minuto, Segundo) em timestamp de 24h, sem separadores GMT-3. Exemplo: `060226-191500` para 6 de fevereiro de 2026 às 19:15:00.

### Tríade obrigatória por entregável

**llm-readable-kit (feature-centric):**
1. **Feature Spec** — problema → solução → fluxo → critérios de aceite
2. **Snippet Técnico** — assinatura + parâmetros + pseudocódigo + código real + grafo de dependências
3. **Guia de Adoção** — pré-requisitos + passos + testes + troubleshooting

**chunkit-core (project-centric):**
1. **Chunk Spec** — o que é → por que existe → quando usar → critérios
2. **Schema/Assinatura** — estrutura e convenções do chunk
3. **Guia de Uso** — como instanciar → como validar → troubleshooting

### Taxonomia de tags

- Mínimo 3 tags por artefato, formato `CATEGORIA:subtopic`

**llm-readable-kit:**
- Categorias: `PROG` (progresso), `PARS` (parsing), `QUEUE` (filas), `UIFB` (UI feedback), `RESIL` (resiliência), `PIPE` (pipeline)

**chunkit-core:**
- Categorias: `ARCH` (arquitetura), `GOV` (governança), `CAF` (Cloud Adoption Framework), `PHASE` (fases), `GATE` (decision gates), `META` (meta-chunking)

## Invariantes (nunca violar)

### llm-readable-kit (feature-centric)

| ID    | Contrato                                                                             |
| ----- | ------------------------------------------------------------------------------------ |
| INV-1 | Funções de parsing NUNCA lançam exceção; retornam `{error:msg}`                      |
| INV-2 | Campos ausentes = neutros (ex: `polarity undefined → 0`, `shape → "circle"`)         |
| INV-3 | Labels: `decodeLabel` = 2 iterações; `fullyDecodeURI` = 5 iterações (string inteira) |
| INV-4 | Loops deduplicados por assinatura de edges ordenadas                                 |
| INV-5 | Projeções são read-only — nunca alteram SemanticGraph ou Model                       |
| INV-6 | `toSemanticJSON` é SSOT semântico; projeções consomem o mesmo graph                  |

### chunkit-core (project-centric)

| ID       | Contrato                                                                      |
| -------- | ----------------------------------------------------------------------------- |
| CHK-INV-1| Chunks NUNCA dependem de implementações específicas de outros projetos        |
| CHK-INV-2| Campos ausentes no Intake = valores padrão neutros                            |
| CHK-INV-3| Nomenclatura obrigatória: `chunkit.<tipo>-<escopo-kebab>.skill.md`           |
| CHK-INV-4| Score mínimo 80/100 antes de HITL                                             |
| CHK-INV-5| HITL é gate obrigatório — nenhum chunk é auto-aprovado                        |
| CHK-INV-6| ID Mestre em formato `DDMMYY-HHMMSS` (GMT-3, 24h, sem separadores)           |

## Scoring (Auto-avaliação Logarítmica L0-L5)

Cada entregável deve atingir ≥ 80/100. Fórmula: `Score = Σ(cobertura × peso)`:

| Nível | Aspecto                                    | Peso |
| ----- | ------------------------------------------ | ---- |
| L0    | Existência (binário)                       | 5%   |
| L1    | Estrutura declarativa                      | 15%  |
| L2    | Schema formal (templates ≥80% preenchidos) | 20%  |
| L3    | Instanciação com dados reais               | 25%  |
| L4    | Rastreabilidade (tags, refs cruzadas)      | 15%  |
| L5    | Metacognição (loop + scoring executado)    | 20%  |

Se score < 80: re-entrar no pipeline no nível deficiente. Máximo 3 iterações.

## Padrão Arquitetural: Pipeline de 4 Camadas

O framework segue o padrão `ingestão → enriquecimento → projeção → entrega`:

```
Camada 0→1: INGESTÃO       parseModelData()    string/array → ParsedModel
Camada 1→2: ENRIQUECIMENTO  toSemanticJSON()    ParsedModel → SemanticGraph
Camada 2→3: PROJEÇÃO        toNL/toLLMPrompt()  SemanticGraph → string formatada
Camada 3:   ENTREGA         Modal/clipboard     display / clipboard / download
```

Projeções são **plugins**: adicionar formato = adicionar 1 função, zero refatoração no core.

## Exemplo de Referência

O arquivo `docs-copy/components/llm-readable.semantic-export.skill.md` é o primeiro entregável aprovado e serve como **referência canônica** de formato e profundidade esperados. Ele **DEVE** ser consultado para qualquer dúvida sobre o padrão de saída.
