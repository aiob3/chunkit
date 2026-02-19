# Template: chunkit.skill.md

**ID Mestre:** 180226-234200
**Tipo:** Template estrutural para chunks de projeto
**Baseado em:** llm-readable.skill.md (llm-readable-kit)

---

## Estrutura Obrigatória

Todo chunk do chunkit-core deve seguir este template para manter consistência com o llm-readable-kit, adaptado para contexto project-centric.

---

## PARTE A: CHUNK SPEC

### 1. Intake (6 campos obrigatórios)

```yaml
Nome:          <nome-do-chunk>
Tipo:          <blueprint | reference | scaffold | validation>
Escopo:        <fase-específica | cross-fase | arquitetural>
Propósito:     <por que este chunk existe>
Dependências:  <lista de outros chunks ou artefatos necessários>
Critérios:     <critérios de aceite para considerar o chunk completo>
```

### 2. Meios Necessários (≥3)

Lista de ferramentas, padrões, templates ou recursos necessários para operacionalizar este chunk:

1. **Meio 1** — descrição
2. **Meio 2** — descrição
3. **Meio 3** — descrição

### 3. Insights de Governança (≥3)

Cada insight deve responder: **Por que** (motivação) + **Onde** (contexto de aplicação) + **Limites** (quando não usar)

**Insight 1: [Título]**
- **Por que:** <motivação>
- **Onde:** <contexto de aplicação>
- **Limites:** <quando não usar>

**Insight 2: [Título]**
- **Por que:** <motivação>
- **Onde:** <contexto de aplicação>
- **Limites:** <quando não usar>

**Insight 3: [Título]**
- **Por que:** <motivação>
- **Onde:** <contexto de aplicação>
- **Limites:** <quando não usar>

---

## PARTE B: FRAMEWORK (Tríade)

### 1. Feature Spec / Chunk Spec

**Problema:**
<descrever o problema que este chunk resolve>

**Solução:**
<descrever como este chunk resolve o problema>

**Fluxo:**
```
[Entrada] → [Processamento] → [Saída]
```

**Critérios de Aceite:**
- [ ] Critério 1
- [ ] Critério 2
- [ ] Critério 3

---

### 2. Snippet Técnico / Schema

Para **blueprints e references** (conceituais):

```yaml
# Schema do Chunk
campos_obrigatórios:
  - campo1: tipo (descrição)
  - campo2: tipo (descrição)
  
campos_opcionais:
  - campo3: tipo (descrição)
  
formato: markdown | yaml | json | custom
convenções:
  - Convenção 1
  - Convenção 2
```

Para **scaffolds e validations** (operacionais):

```javascript
// Pseudocódigo ou assinatura
function nomeDoChunk(parametros) {
  // Lógica principal
  // ...
  return resultado;
}
```

**Código Real:**
```<linguagem>
// Implementação real ou template
// ...
```

**Grafo de Dependências:**
```
ChunkA → ChunkB → [ArtefatoX]
       ↓
     ChunkC → [ArtefatoY]
```

---

### 3. Guia de Adoção

**Pré-requisitos:**
- Pré-requisito 1
- Pré-requisito 2

**Passos de Uso:**
1. Passo 1
2. Passo 2
3. Passo 3

**Validação:**
```bash
# Comando de validação
<VALIDATION_COMMAND>
```

**Troubleshooting:**

| Problema                | Causa Provável           | Solução                    |
| ----------------------- | ------------------------ | -------------------------- |
| Problema comum 1        | Causa                    | Como resolver              |
| Problema comum 2        | Causa                    | Como resolver              |

---

## PARTE C: METADATA

### Tags

`<CATEGORIA:subtopic>`, `<CATEGORIA:subtopic>`, `<CATEGORIA:subtopic>`

Categorias do chunkit-core:
- `ARCH` (arquitetura)
- `GOV` (governança)
- `CAF` (Cloud Adoption Framework)
- `PHASE` (fases de projeto)
- `GATE` (decision gates)
- `META` (meta-chunking)

### Cross-References

- Relacionado: `[outro-chunk.skill.md]`
- Depende de: `[dependência.skill.md]`
- Usado por: `[consumidor.skill.md]`

### Invariantes Aplicadas

Lista de invariantes que este chunk respeita (referência: `docs-copy/chunks/07-invariants.md`)

---

## PARTE D: AUTO-AVALIAÇÃO (Scoring L0-L5)

Score = Σ(cobertura × peso)

| Nível | Aspecto                                    | Peso | Cobertura | Parcial |
| ----- | ------------------------------------------ | ---- | --------- | ------- |
| L0    | Existência (binário)                       | 5%   | 100%      | 5.0     |
| L1    | Estrutura declarativa                      | 15%  | <%>       | <calc>  |
| L2    | Schema formal (templates ≥80% preenchidos) | 20%  | <%>       | <calc>  |
| L3    | Instanciação com dados reais               | 25%  | <%>       | <calc>  |
| L4    | Rastreabilidade (tags, refs cruzadas)      | 15%  | <%>       | <calc>  |
| L5    | Metacognição (loop + scoring executado)    | 20%  | <%>       | <calc>  |

**Score Total:** <somatório> / 100

**Status:** <APROVADO se ≥80 | REQUER ITERAÇÃO se <80>

---

## Aprovação HITL

**Status:** 🟡 PENDENTE
**Revisor:** <operador>
**Data de revisão:** <TBD>
**Decisão:** <Aprovado | Inferência necessária | Iteração necessária | Refatoração necessária>
**Feedback:** <comentários do operador>

---

**Nota:** Este template serve como base estrutural. Cada chunk concreto deve preencher todas as seções com conteúdo específico ao seu propósito.
