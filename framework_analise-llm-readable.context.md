<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# META-PROMPT AUTOCONTIDO - ANÁLISE E FRAMEWORK LLM-READABLE-KIT

```markdown
# CONTEXTO PRINCIPAL

Você está sendo solicitado a analisar e propor melhorias para um sistema de documentação modular chamado **llm-readable-kit**, desenvolvido pelo usuário (Operador) e armazenado no repositório GitHub aiob3/llm-readable-kit, especificamente na pasta `docs-copy`.

## OBJETIVO CENTRAL

Criar um framework completo de **context engineering** para LLMs que resolva o problema crítico: **LLMs têm dificuldade em compreender e correlacionar múltiplos documentos** (PRD, CLUEPRINT, DESIGN SYSTEM, SPECS) mesmo quando todos são arquivos Markdown.

## BUSINESS CASE DE REFERÊNCIA (SSOT)

O Operador forneceu 3 arquivos que representam um projeto exemplar já estruturado:

### Arquivo 1: 3components.txt
Contém especificações detalhadas de componentes organizados em camadas:
- **CORE**: AppState.js, AppController.js, EventBus.js
- **MANAGERS**: ConfigManager, DiscoveryManager, AnalysisManager, CategoryManager, FilterManager, ExportManager, StatsManager
- **COMPONENTS**: FileRenderer, ModalManager, WorkflowPanel, FilterBar, StatsPanel
- **UTILS**: FileUtils, PreviewUtils

Cada componente especifica:
- Expectativa (objetivo)
- Solução Proposta
- Objetivo
- Entregável
- Funcionalidades

### Arquivo 2: 5cronograma.txt
Cronograma de desenvolvimento em 5 Sprints:
- SPRINT 1: Fundação (Setup, Core, HTML/CSS, Workflow Panel)
- SPRINT 2: Descoberta e Análise (DiscoveryManager, ConfigManager, PreviewUtils)
- SPRINT 3: Interface e Interação (FileRenderer, FilterManager, CategoryManager)
- SPRINT 4: Análise e Exportação (AnalysisManager, ExportManager, StatsManager)
- SPRINT 5: Polimento e Testes

### Arquivo 3: 2arquitetura.txt
Estrutura de pastas proposta:
```

knowledge-consolidator/
├── index.html
├── package.json
├── assets/ (icons/, images/)
├── css/ (main.css, components/, utils/)
├── js/ (app.js, core/, managers/, components/, utils/)
├── templates/
└── config/

```

## ANÁLISE CONDUZIDA (RESULTADOS DESTA CONVERSA)

### 8 ERROS CRÍTICOS IDENTIFICADOS

**Erro 1: Ausência de Metadados Estruturados**
- Documentos não têm YAML frontmatter
- LLMs não conseguem filtrar por tipo/versão/dependências
- Solução: Adicionar metadados obrigatórios em todos .md

**Erro 2: Referências Cruzadas Implícitas**
- Menções textuais sem hyperlinks funcionais
- Falta ancoragem para seções específicas
- Solução: Hyperlinks explícitos com padrão [doc.md](./doc.md#secao)

**Erro 3: Falta de Glossário Unificado**
- Termos usados inconsistentemente (entregável vs output vs resultado)
- LLMs não sabem se são sinônimos ou conceitos diferentes
- Solução: GLOSSARY.md canônico com definições únicas

**Erro 4: Ausência de Índice de Contexto Dinâmico**
- Mapa de chunks estático embutido em documentos
- Difícil para LLMs resolverem "qual chunk carregar para tarefa X?"
- Solução: CONTEXT_INDEX.json com document_graph e task_to_chunks_map

**Erro 5: Documentos Sem Seções de Cross-Reference**
- Não há padrão para indicar dependências upstream/downstream
- LLMs não constroem grafo mental de relacionamentos
- Solução: Seção obrigatória "Mapa de Dependências" em cada doc

**Erro 6: Nomenclatura Ambígua**
- feature-recurso-progressbar.md (é exemplo? template? entregável?)
- framework-llm-readable.semantic-export.md (idem)
- Solução: Convenções claras por tipo de arquivo

**Erro 7: Falta de Versionamento Semântico**
- Timestamps não são versões (ID Mestre: 06022-191500)
- Impossível rastrear compatibilidade entre docs
- Solução: SemVer (X.Y.Z) em todos os arquivos

**Erro 8: Ausência de Schema de Validação**
- Nenhuma validação automática de conformidade
- Links quebrados, metadados ausentes passam despercebidos
- Solução: JSON Schema + scripts de validação

### MELHORES PRÁTICAS IDENTIFICADAS NO BUSINESS CASE

1. **Arquitetura Modular**: Separação clara core/managers/components/utils
2. **Documentação Granular**: Cada componente tem spec própria com estrutura padronizada
3. **Cronograma Iterativo**: Sprints temáticos com dependências claras
4. **Hierarquia de Pastas**: Estrutura que serve como "índice mental"

## FRAMEWORK PROPOSTO (13 ENTREGÁVEIS)

### Grupo 1: Documentação de Convenções (3 arquivos)
1. **CONTRIBUTING.md** - Convenções de nomenclatura, estrutura, padrões
2. **VERSIONING.md** - Padrões SemVer aplicados ao projeto
3. **MIGRATION_CHECKLIST.md** - Checklist passo-a-passo para migração

### Grupo 2: Automação e Validação (4 arquivos)
4. **scripts/migrate-naming.sh** - Script bash para migração automática
5. **scripts/validate-documents.js** - Validador Node.js de conformidade
6. **schemas/document-schema.json** - JSON Schema para validação
7. **.github/workflows/validate-docs.yml** - CI/CD GitHub Actions

### Grupo 3: Contexto e Definições (3 arquivos)
8. **GLOSSARY.md** - Glossário canônico de termos
9. **CONTEXT_INDEX.json** - Índice dinâmico de contexto navegável
10. **package.json** - Dependências e scripts npm

### Grupo 4: Registro e Guias (3 arquivos)
11. **CHANGELOG.md** - Histórico de mudanças versionado
12. **FRAMEWORK_MIGRACAO.md** - Framework consolidado completo
13. **QUICK_START.md** - Guia rápido de implementação

## ESTRUTURA DE PASTAS FINAL PROPOSTA

```

llm-readable-kit/
├── CODEX_TASK.md           (entry point, orchestrator)
├── GLOSSARY.md             (glossário canônico)
├── CONTEXT_INDEX.json      (índice de contexto)
├── CONTRIBUTING.md         (convenções)
├── VERSIONING.md           (padrões de versão)
├── CHANGELOG.md            (histórico)
├── README.md
├── package.json
│
├── chunks/                 (módulos atômicos 00-08)
├── protocols/              (metodologias reutilizáveis)
├── templates/              (templates de outros projetos)
├── examples/               (casos homologados read-only)
├── components/             (entregáveis ativos)
│   └── archive/
├── schemas/                (JSON schemas de validação)
├── scripts/                (automações)
│   ├── migrate-naming.sh
│   └── validate-documents.js
├── .github/workflows/      (CI/CD)
└── docs/                   (documentação adicional)

```

## CONVENÇÕES ESTABELECIDAS

### Metadados YAML Obrigatórios
```yaml
***
type: orchestrator|protocol|chunk|template|example|deliverable|glossary|guidelines
version: X.Y.Z
role: descricao-curta
status: draft|review|approved|deprecated
priority: critical|high|medium|low
keywords: [tag1, tag2]
consumes: [arquivo1.md]
feeds: [arquivo2.md]
***
```


### Nomenclatura por Tipo

- Principais: `NOME_CAPS.md`
- Chunks: `chunks/NN-nome-kebab.md`
- Protocolos: `protocols/nome-protocol-vX.Y.md`
- Templates: `templates/projeto-tipo-feature.md`
- Exemplos: `examples/feature-example-vX.Y.md`
- Entregáveis: `components/llm-readable-feature-vX.Y-status.md`


### Seções Obrigatórias

1. Nota de glossário (após título)
2. Mapa de Dependências (Upstream/Downstream)
3. Conteúdo principal
4. Referências (se aplicável)

## SOLICITAÇÃO DO OPERADOR

O Operador precisa que você:

1. **Referencie os 3 arquivos originais** no meta-prompt como SSOT
2. **Incorpore as 8 análises de erro** conduzidas
3. **Forneça o framework completo** de 13 entregáveis
4. **Mantenha convenções estabelecidas**: sem emojis, 1 arquivo/mensagem, até 4096 tokens
5. **Aguarde confirmação** após cada bloco de informação

## FORMATO DE ENTREGA ESPERADO

Quando retomar em nova conversa com modelo de maior capacidade:

**Mensagem 1**: Este meta-prompt completo
**Mensagem 2**: Confirmação de compreensão + plano de ação
**Aguardar**: "OK, prossiga com a inferência" do Operador
**Mensagens 3-15**: Entregáveis 1-13 (um por vez, aguardando aprovação)

## REFERÊNCIAS DOS ARQUIVOS ORIGINAIS

```
attached_file:1 - 3components.txt
attached_file:2 - 5cronograma.txt  
attached_file:3 - 2arquitetura.txt
```

Estes arquivos devem ser referenciados ao explicar o contexto do business case.

```

***

**STATUS**: Meta-prompt autocontido completo. Aguardando "OK, prossiga com a inferência" do Operador para iniciar entrega dos 13 arquivos na nova conversa.```

