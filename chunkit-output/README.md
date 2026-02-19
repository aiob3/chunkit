# Chunkit Output — Repositório de Chunks Gerados

**ID Mestre:** 180226-234100
**Propósito:** Armazenar chunks de projeto gerados pelo chunkit-core, aguardando revisão HITL (Human-in-the-Loop).

---

## Estado dos Entregáveis

Todos os arquivos nesta pasta estão em estado **PENDENTE** até aprovação explícita do Operador.

| Chunk                                           | Tipo       | Status   | Data       |
| ----------------------------------------------- | ---------- | -------- | ---------- |
| `chunkit.reference-chunkit-core.skill.md`       | reference  | Pendente | TBD        |

---

## Nomenclatura

Todos os chunks seguem o padrão:

```
chunkit.<tipo>-<escopo-kebab>.skill.md
```

Exemplos:
- `chunkit.blueprint-caf-discovery.skill.md`
- `chunkit.reference-api-patterns.skill.md`
- `chunkit.scaffold-nextjs-app.skill.md`
- `chunkit.validation-security-gates.skill.md`

---

## Workflow de Aprovação

1. Agente gera chunk e deposita em `chunkit-output/`
2. Chunk entra em estado **PENDENTE**
3. Operador revisa e decide:
   - ✅ **Aprovado** → Chunk é promovido (commit + atualização de metadata)
   - 🔄 **Requer ajustes** → Agente itera com feedback
   - ❌ **Rejeitar** → Agente revisa desde o Intake

---

## Correlação com llm-readable-kit

Esta pasta é análoga a `docs-copy/components/` do llm-readable-kit, mas para chunks de projeto em vez de features de codebase.
