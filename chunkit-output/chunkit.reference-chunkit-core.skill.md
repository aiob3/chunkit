# chunkit.reference-chunkit-core.skill.md

**ID Mestre:** 180226-234300
**Tipo:** reference
**Escopo:** arquitetural
**Status:** 🟡 PENDENTE HITL
**Correlação:** [`aiob3/llm-readable-kit`](https://github.com/aiob3/llm-readable-kit)

---

## PARTE A: CHUNK SPEC

### 1. Intake

```yaml
Nome:          chunkit-core
Tipo:          reference
Escopo:        arquitetural
Propósito:     Documentar o chunkit-core como sistema de governança de chunks de projeto, 
               adotando o llm-readable-kit como dependência estrutural e conceitual
Dependências:  llm-readable-kit (modelo operacional), Fundation Agent protocol, skill.md format
Critérios:     - Tríade completa documentada
               - Correlação 1:1 com llm-readable-kit estabelecida
               - Diferenças feature-centric vs project-centric explicitadas
               - Workflow de HITL + scoring implementado
```

### 2. Meios Necessários

1. **CHUNKIT_TASK.md** — Entry point canônico para execução de agentes, define variáveis de input e workflow sequencial
2. **chunkit.skill.md format** — Template estrutural baseado em llm-readable.skill.md, adaptado para chunks de projeto
3. **chunkit-output/** — Repositório de entregáveis aguardando revisão HITL (análogo a docs-copy/components/)
4. **Taxonomia de chunks** — blueprint | reference | scaffold | validation (4 tipos primários)
5. **Scoring L0-L5** — Sistema de auto-avaliação logarítmica herdado do llm-readable-kit (mínimo 80/100)

### 3. Insights de Governança

**Insight 1: Desacoplamento por Modelo Operacional**
- **Por que:** O chunkit-core precisa de atomicidade idempotente sem depender de implementações específicas de outros projetos
- **Onde:** Na definição de dependências — adota apenas o **modelo operacional** (skill.md, HITL, scoring) do llm-readable-kit, não suas features ou código
- **Limites:** Não aplicar quando houver necessidade de compartilhar código executável entre projetos; este padrão é para governança documental

**Insight 2: Dualidade Feature-centric vs Project-centric**
- **Por que:** O llm-readable-kit documenta features de codebase; o chunkit-core documenta fases e artefatos de projeto — ambos precisam de estrutura padronizada mas com focos distintos
- **Onde:** Na definição do pipeline — llm-readable usa "Ingestão→Enriquecimento→Projeção→Entrega" para código; chunkit usa "Intake→Derivação→Síntese→Entrega" para governança
- **Limites:** A dualidade não implica incompatibilidade; ambos convergem no formato final (skill.md) e nos gates (HITL + scoring)

**Insight 3: Meta-chunking como Prova de Auto-suficiência**
- **Por que:** Um kit de documentação deve ser capaz de documentar a si mesmo no formato que define, provando completude
- **Onde:** Este arquivo é o primeiro meta-chunk: documenta o próprio chunkit-core usando o formato chunkit.skill.md
- **Limites:** Meta-chunks são referências arquiteturais, não substituem documentação operacional ou guias de usuário

---

## PARTE B: FRAMEWORK (Tríade)

### 1. Chunk Spec

**Problema:**
O chunkit-core precisa estruturar governança de projetos (fases CAF, blueprints, scaffolds, validações) de forma tão padronizada e replicável quanto o llm-readable-kit estrutura features de codebase. Sem um formato canônico de chunk, cada projeto reinventa convenções, gerando inconsistência e perda de rastreabilidade.

**Solução:**
Adotar o llm-readable-kit como **dependência estrutural** — reutilizar protocolo Fundation Agent, formato skill.md e sistema de validação (HITL + scoring L0-L5) — mas aplicar ao contexto **project-centric** em vez de feature-centric. Cada chunk de projeto (blueprint, reference, scaffold, validation) torna-se um artefato autocontido com a tríade obrigatória.

**Fluxo:**

```
[CHUNKIT_TASK.md + variáveis]
         ↓
[Pipeline adaptado: Intake → Derivação → Síntese → Entrega]
         ↓
[chunkit.<tipo>-<escopo>.skill.md gerado]
         ↓
[Gate HITL: Operador revisa e aprova/itera]
         ↓
[Chunk promovido + metadata atualizada]
```

**Critérios de Aceite:**
- [x] CHUNKIT_TASK.md criado como entry point canônico
- [x] Template chunkit.skill.md definido com tríade obrigatória
- [x] Pasta chunkit-output/ criada para entregáveis pendentes HITL
- [x] Taxonomia de 4 tipos de chunks documentada (blueprint/reference/scaffold/validation)
- [x] Correlação 1:1 com llm-readable-kit mapeada
- [x] Scoring L0-L5 adaptado para validação de chunks
- [ ] Primeiro chunk de exemplo validado (este arquivo, após HITL)
- [ ] README.md atualizado com correlação explícita

---

### 2. Schema / Assinatura

**Schema do chunkit.skill.md:**

```yaml
metadata:
  id_mestre: DDMMYY-HHMMSS
  tipo: blueprint | reference | scaffold | validation
  escopo: fase-específica | cross-fase | arquitetural
  status: PENDENTE | APROVADO | REQUER_ITERACAO
  correlacao: link para projeto/kit relacionado (se aplicável)

parte_a_chunk_spec:
  intake:
    nome: string
    tipo: enum
    escopo: enum
    proposito: string (multi-linha)
    dependencias: array[string]
    criterios: array[string]
  meios_necessarios: array[objeto] (≥3)
  insights_governanca: array[objeto] (≥3, cada um com 3 dimensões)

parte_b_framework:
  chunk_spec:
    problema: string (multi-linha)
    solucao: string (multi-linha)
    fluxo: diagram (texto ou Mermaid)
    criterios_aceite: array[checklist]
  schema_assinatura:
    # Para chunks conceituais (blueprint/reference)
    schema_yaml: string
    # Para chunks operacionais (scaffold/validation)
    pseudocodigo: string
    codigo_real: string (se aplicável)
    grafo_dependencias: diagram
  guia_uso:
    prerequisitos: array[string]
    passos: array[string]
    validacao: comando ou checklist
    troubleshooting: table

parte_c_metadata:
  tags: array[string] (≥3, formato CATEGORIA:subtopic)
  cross_references:
    relacionado: array[string]
    depende_de: array[string]
    usado_por: array[string]
  invariantes_aplicadas: array[string]

parte_d_autoavaliacao:
  scoring_l0_l5:
    l0_existencia: 5% × cobertura
    l1_estrutura: 15% × cobertura
    l2_schema: 20% × cobertura
    l3_instanciacao: 25% × cobertura
    l4_rastreabilidade: 15% × cobertura
    l5_metacognicao: 20% × cobertura
  score_total: número (0-100)
  status_validacao: APROVADO | REQUER_ITERACAO

aprovacao_hitl:
  status: PENDENTE | APROVADO | AJUSTES_SOLICITADOS | REJEITADO
  revisor: string (operador)
  data_revisao: DDMMYY
  decisao: enum
  feedback: string (multi-linha)
```

**Convenções:**
- Nomenclatura de arquivo: `chunkit.<tipo>-<escopo-kebab>.skill.md`
- ID Mestre em formato `DDMMYY-HHMMSS` (GMT-3, 24h, sem separadores)
- Toda documentação em PT-BR, código em inglês
- Mínimo 3 tags por chunk
- Score mínimo 80/100 antes de HITL

**Grafo de Dependências:**

```
CHUNKIT_TASK.md
      ↓
[Protocolo Fundation Agent] (reutilizado de llm-readable-kit)
      ↓
[Pipeline: Intake → Derivação → Síntese → Entrega]
      ↓
chunkit.<tipo>-<escopo>.skill.md
      ↓
[Scoring L0-L5 ≥ 80/100]
      ↓
[Gate HITL: Operador aprova/itera]
      ↓
[Chunk promovido + metadata atualizada]
```

---

### 3. Guia de Adoção

**Pré-requisitos:**
- Acesso ao repositório do projeto-alvo
- Variáveis de input preenchidas no CHUNKIT_TASK.md
- Compreensão do protocolo Fundation Agent (ler `docs-copy/fundation-agent.prompt.md`)
- Familiaridade com o formato skill.md (consultar exemplos em `docs-copy/components/`)

**Passos de Uso:**

1. **Preencher CHUNKIT_TASK.md:**
   ```yaml
   PROJECT_NAME       = <nome-do-projeto>
   CHUNK_TYPE         = <blueprint | reference | scaffold | validation>
   CHUNK_SCOPE        = <escopo-do-chunk>
   TARGET_ARTIFACTS   = <lista de artefatos governados>
   VALIDATION_COMMAND = <comando de validação>
   OUTPUT_DIR         = chunkit-output/
   ```

2. **Executar pipeline:**
   - Acionar agente com `CHUNKIT_TASK.md` como entry point
   - Agente executa: Intake → Derivação → Síntese → Entrega
   - Output gerado em `chunkit-output/chunkit.<tipo>-<escopo>.skill.md`

3. **Validar chunk gerado:**
   - Verificar tríade completa (Chunk Spec + Schema + Guia)
   - Rodar `VALIDATION_COMMAND` (se aplicável)
   - Calcular score L0-L5 (deve ser ≥ 80/100)

4. **Submeter para HITL:**
   - Depositar chunk em `chunkit-output/` com status PENDENTE
   - Aguardar revisão do Operador
   - Implementar feedback e iterar se necessário

5. **Promover chunk aprovado:**
   - Após aprovação HITL, atualizar status para APROVADO
   - Registrar em metadata de projeto (ex: convergence-metadata.yml)
   - Chunk agora é parte da governança do projeto

**Validação:**

```bash
# Validar formato do chunk
grep -E "^## PARTE [A-D]:" chunkit-output/chunkit.*.skill.md

# Validar presença de tríade
grep -E "(Chunk Spec|Schema|Guia de Uso)" chunkit-output/chunkit.*.skill.md

# Validar scoring
grep -E "Score Total:" chunkit-output/chunkit.*.skill.md
```

**Troubleshooting:**

| Problema                          | Causa Provável                             | Solução                                                      |
| --------------------------------- | ------------------------------------------ | ------------------------------------------------------------ |
| Score < 80/100                    | Templates incompletos ou dados ausentes    | Re-executar pipeline com mais contexto no Intake             |
| Tríade incompleta                 | Pipeline pulou etapas obrigatórias         | Verificar que todos os chunks necessários foram carregados   |
| VALIDATION_COMMAND falha          | Chunk não atende critérios operacionais    | Revisar Chunk Spec e ajustar solução proposta                |
| Formato inconsistente com template| Desvio durante geração                     | Consultar TEMPLATE.chunkit.skill.md e re-gerar               |
| Dependências não resolvidas       | Chunks dependentes não foram gerados ainda | Gerar chunks dependentes primeiro, seguindo grafo            |

---

## PARTE C: METADATA

### Tags

`ARCH:chunking`, `GOV:hitl-gates`, `META:self-documentation`

### Cross-References

- **Relacionado:** `docs-copy/CODEX_TASK.md` (protocolo original do llm-readable-kit)
- **Depende de:** `docs-copy/fundation-agent.prompt.md` (protocolo Fundation Agent)
- **Depende de:** `TEMPLATE.chunkit.skill.md` (template estrutural)
- **Usado por:** Todos os futuros chunks do chunkit-core

### Invariantes Aplicadas

Adaptadas de `docs-copy/chunks/07-invariants.md`:

| ID       | Contrato Chunkit-Core                                                            |
| -------- | -------------------------------------------------------------------------------- |
| CHK-INV-1| Chunks NUNCA dependem de implementações específicas de outros projetos           |
| CHK-INV-2| Campos ausentes no Intake = valores padrão neutros                               |
| CHK-INV-3| Nomenclatura obrigatória: `chunkit.<tipo>-<escopo-kebab>.skill.md`              |
| CHK-INV-4| Score mínimo 80/100 antes de HITL                                                |
| CHK-INV-5| HITL é gate obrigatório — nenhum chunk é auto-aprovado                           |
| CHK-INV-6| ID Mestre em formato `DDMMYY-HHMMSS` (GMT-3, 24h, sem separadores)              |

---

## PARTE D: AUTO-AVALIAÇÃO (Scoring L0-L5)

| Nível | Aspecto                                    | Peso | Cobertura | Parcial |
| ----- | ------------------------------------------ | ---- | --------- | ------- |
| L0    | Existência (binário)                       | 5%   | 100%      | 5.0     |
| L1    | Estrutura declarativa                      | 15%  | 100%      | 15.0    |
| L2    | Schema formal (templates ≥80% preenchidos) | 20%  | 95%       | 19.0    |
| L3    | Instanciação com dados reais               | 25%  | 90%       | 22.5    |
| L4    | Rastreabilidade (tags, refs cruzadas)      | 15%  | 100%      | 15.0    |
| L5    | Metacognição (loop + scoring executado)    | 20%  | 100%      | 20.0    |

**Score Total:** 96.5 / 100

**Status:** ✅ APROVADO (≥80)

**Justificativa:**
- L0-L1: Documento existe e segue estrutura declarativa obrigatória
- L2: Templates preenchidos em ~95% (Schema YAML completo, exemplos concretos)
- L3: Dados reais instanciados (este próprio chunk é o exemplo)
- L4: Tags, cross-references e invariantes documentadas
- L5: Scoring executado nesta seção; meta-cognição presente (chunk documenta a si mesmo)

**Áreas de Melhoria (para iterar se Operador solicitar):**
- Adicionar mais exemplos concretos de blueprints e scaffolds
- Incluir código de validação automatizada para conferir formato de chunks
- Expandir troubleshooting com casos reais após uso em projetos

---

## PARTE E: APROVAÇÃO HITL

**Status:** 🟡 PENDENTE
**Revisor:** Operador
**Data de revisão:** TBD
**Decisão:** <Aguardando>
**Feedback:** 

---

## Apêndice A: Mapeamento 1:1 com llm-readable-kit

| Conceito                   | llm-readable-kit                      | chunkit-core                              |
| -------------------------- | ------------------------------------- | ----------------------------------------- |
| Entry point                | `CODEX_TASK.md`                       | `CHUNKIT_TASK.md`                         |
| Unidade atômica            | `skill.md` (feature)                  | `chunkit.skill.md` (chunk de projeto)     |
| Pasta de entrega           | `docs-copy/components/`               | `chunkit-output/`                         |
| Pipeline                   | Ingestão→Enriquecimento→Projeção      | Intake→Derivação→Síntese                  |
| Tríade                     | Feature Spec + Snippet + Guia         | Chunk Spec + Schema + Guia                |
| Validação                  | Score L0-L5 ≥ 80/100 + HITL           | Score L0-L5 ≥ 80/100 + HITL               |
| Protocolo de execução      | `fundation-agent.prompt.md`           | Reutilizado do llm-readable-kit           |
| Idempotência               | Copy/paste docs-copy/ + preencher vars| Copy/paste chunkit/ + preencher vars      |
| Taxonomia de saída         | llm-readable.`<feature>`.skill.md     | chunkit.`<tipo>`-`<escopo>`.skill.md      |
| ID Mestre                  | `DDMMYY-HHMMSS` (GMT-3)               | `DDMMYY-HHMMSS` (GMT-3)                   |

---

## Apêndice B: Tipos de Chunks (Taxonomia Primária)

### Blueprint

**Propósito:** Define estrutura e governança de uma fase de projeto (ex: CAF Discovery, CAF Design, Implementation).

**Output típico:**
- Artefatos obrigatórios da fase
- Critérios de entrada e saída (decision gates)
- Templates de documentos (requirements, risk register, architecture decision records)
- Checklist de validação

**Exemplo:** `chunkit.blueprint-caf-discovery.skill.md`

---

### Reference

**Propósito:** Documenta padrões, convenções e decisões arquiteturais que transcendem fases individuais.

**Output típico:**
- Padrões de API (REST, GraphQL, gRPC)
- Convenções de naming
- Decisões de stack tecnológico
- Políticas de segurança e compliance

**Exemplo:** `chunkit.reference-api-patterns.skill.md`

---

### Scaffold

**Propósito:** Fornece templates e código boilerplate reutilizável para acelerar setup de novos componentes ou projetos.

**Output típico:**
- Estrutura de diretórios
- Arquivos de configuração (tsconfig, webpack, docker-compose)
- Código inicial (controllers, models, tests)
- Scripts de setup e build

**Exemplo:** `chunkit.scaffold-nextjs-app-structure.skill.md`

---

### Validation

**Propósito:** Define critérios de aceite, checklists e gates de qualidade para garantir conformidade.

**Output típico:**
- Checklists de code review
- Critérios de performance (response time, bundle size)
- Gates de segurança (vulnerability scanning, secrets detection)
- Definições de "done" por fase

**Exemplo:** `chunkit.validation-security-gates.skill.md`

---

## Apêndice C: Workflow de Bootstrapping Idempotente

O chunkit-core herda o padrão de bootstrapping do llm-readable-kit:

### Passo 1: Setup inicial (uma vez por projeto)

```bash
# Clonar ou copiar estrutura do chunkit
git clone <chunkit-repo> ou cp -r chunkit/ /projeto-alvo/

# Estrutura copiada:
chunkit/
├── CHUNKIT_TASK.md        ← Entry point
├── docs-copy/             ← Kit llm-readable reutilizado (referência)
├── chunkit-output/        ← Pasta de entrega
└── TEMPLATE.chunkit.skill.md
```

### Passo 2: Preencher variáveis (toda execução)

Editar `CHUNKIT_TASK.md`:

```yaml
PROJECT_NAME       = meu-novo-projeto
CHUNK_TYPE         = blueprint
CHUNK_SCOPE        = fase-caf-discovery
TARGET_ARTIFACTS   = requirements.md, stakeholder-map.md
VALIDATION_COMMAND = ./scripts/validate-discovery.sh
```

### Passo 3: Executar (agente autônomo)

```bash
# Agente lê CHUNKIT_TASK.md como entry point
# Executa pipeline: Intake → Derivação → Síntese → Entrega
# Gera: chunkit-output/chunkit.blueprint-caf-discovery.skill.md
```

### Passo 4: HITL Gate

```
Operador revisa → [Aprovado | Ajustes | Rejeitar]
       ↓                ↓              ↓
   Promover        Iterar loop    Descartar
```

### Passo 5: Repetir para próximo chunk

```yaml
# Mesmo CHUNKIT_TASK.md, novas variáveis
CHUNK_TYPE  = scaffold
CHUNK_SCOPE = nextjs-app
# ... re-executar
```

**Idempotência garantida por:**
- Entry point único (CHUNKIT_TASK.md)
- Pipeline determinístico (mesmas variáveis → mesmo output)
- Formato padronizado (template chunkit.skill.md)
- Validação objetiva (score L0-L5)
- Aprovação humana (HITL gate)

---

## Apêndice D: Boundary de Dependências

Para preservar atomicidade do chunkit-core:

```
[llm-readable-kit]
       ↓ (dependência estrutural APENAS)
   modelo operacional:
   - skill.md format
   - Fundation Agent protocol
   - HITL + scoring L0-L5
   - Idempotência via copy/paste
       ↓
[chunkit-core]
   Adapta para project-centric:
   - chunkit.skill.md
   - Taxonomia: blueprint/reference/scaffold/validation
   - Grafo de chunks + governança
       ↓ (NÃO depende de)
   ✗ Implementações específicas de features
   ✗ Código de outros projetos
   ✗ Detalhes de stacks tecnológicos externos
```

**Regra de ouro:**
> "O chunkit-core adota o **como fazer** do llm-readable-kit, não o **o que fazer**."

---

**Fim do documento. Aguardando aprovação HITL.**
