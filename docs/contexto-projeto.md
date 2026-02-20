// contexto-projeto.md
# CONTEXTO DO PROJETO - mywai  (versao 2026 - SECI WAI)
**SSOT - Fonte Única de Verdade**  
**ID Base: 161125-190900**

---

## VISÃO GERAL

### Identificação  
- **Nome do Projeto**: mywai (Move Your Workflow With AI)  
- **Tagline**: Plataforma visual para modelagem de sistemas dinâmicos e workflows com IA  
- **URL Desenvolvimento**: http://127.0.0.1:8080/  
- **Empresa**: VCIA (venture própria)

### Propósito  
Plataforma visual para modelar sistemas dinâmicos e workflows alimentados por IA, com foco em:  
- Automação de processos com IA  
- Orquestração de LLMs e agentes  
- Integração de múltiplas fontes de dados  
- Workflows configuráveis visualmente

---

## MODELO SECI

*Este documento estabelece SECI como pilar central imutável do MyWAI.*  
*Todas as decisões técnicas, de produto e estratégia devem alinhar-se a este framework.*

- **Definição canônica:** ✅ Gerada
- **Embasamento teórico:** ✅ Nonaka & Takeuchi (1995)
- **Critérios objetivos:** ✅ Mensuráveis
- **Código contextual:** ✅ 4 fases implementadas/projetadas
- **Success Factor:** ✅ Fundacional e sólido

📌 adicionar ao contexto `contexto-projeto-seci.md` para detalhamento tácito planejado.

---

## STACK TECNOLÓGICO

### Desenvolvimento  
- **Linguagens**: Python, JavaScript/Node.js, SQL, Bash  
- **IDEs**: VSCode, Cursor IDE, WindSurf  
- **Ambiente**: WSL2, Ubuntu, Zorin OS (Linux)  
- **Controle de Versão**: GitHub

### AI/ML  
- **LLMs Integrados**: Claude (Anthropic), Gemini, Perplexity AI  
- **Modelos Avaliados**: Qwen, DeepSeek  
- **Protocolo**: Model Context Protocol (MCP)  
- **Orquestração**: Integração e orquestração de LLMs

### Infraestrutura  
- **Containerização**: Docker, Docker Compose  
- **Bancos de Dados**: PostgreSQL, Redis  
- **Vector DB**: Qdrant (em avaliação)  
- **Cloud**: AWS/Plataformas em nuvem  
- **Deployment**: VPS self-hosted  
- **Ferramentas DevOps**: Dokku, Portainer (avaliados)  
- **Automação de Workflows**: N8N (em avaliação)

### Networking  
- **Docker Networking**: Configuração macvlan  
- **Monitoramento**: Ferramentas de monitoramento em tempo real

---

## CONTEXTO DE NEGÓCIO

### Experiência do Founder  
- **Background**: Mais de 20 anos em pré-vendas e funções técnicas  
- **Expertise**: Full-stack, DevOps, infraestrutura AI/ML  
- **Foco Atual**: Produtos com IA e sistemas escaláveis

### Abordagem de Desenvolvimento  
- **Metodologia**: Design Thinking + Princípio de Pareto  
- **Faseamento**: Protótipo → Validação → MVP → Iteração  
- **Timing**: Sem prazos fixos curtos; prova de conceito antes de estimativas  
- **Interação**: Man-in-the-loop com referências explícitas

### Objetivos Estratégicos  
1. Construir sistemas escaláveis com IA  
2. Integrar múltiplos LLMs de forma orquestrada  
3. Criar workflows visuais configuráveis  
4. Hospedagem própria em infraestrutura VPS  
5. Documentação rastreável por sistema de IDs

---

## CONFIGURAÇÃO DE TRABALHO

### Hardware  
- **Setup Multi-monitor**: 3 monitores  
  - Monitor Esquerdo: 75Hz @ 2560×1080  
  - Monitor Principal: 165Hz @ 3440×1440 (ultrawide)  
  - Monitor Auxiliar: 144Hz @ 2560×1440  
- **Propósito**: Qualidade de display, inspiração de negócio, motivação

### Software & Ferramentas  
- **Assistentes de IA**: Claude Desktop, Perplexity AI, Gemini  
- **Desenvolvimento**: Docker Desktop, VS Code, Cursor, WindSurf  
- **Terminal**: WSL2 (Ubuntu)  
- **Gerenciadores de Pacotes**: winget, chocolatey (Windows)  
- **Automação**: Aliases/shortcuts personalizados

---

## PROJETOS RELACIONADOS

### Branding  
- **Nome Base**: "locomotiva" / variantes IOKoMMoTIWA  
- **Domínios Considerados**:  
  - lokommotiwa.com  
  - locommotiva.com  
  - yokommotiwa.com  
- **Foco**: Numerologia, implicações de branding, comprimento do nome

### Workspace Perplexity (Atual)  
- **Objetivo**: Centralizar informações do projeto  
- **Função**: Repositório SSOT para consultas futuras  
- **Sistema**: Rastreabilidade por IDs [Principal]-[N+1]  
- **Documentação**: Arquivos .md segmentados

---

## DECISÕES TÉCNICAS RECENTES

### Deployment  
- **Escolha**: VPS self-hosted com containers  
- **Ferramentas Avaliadas**: Dokku, Portainer  
- **Banco de Dados**: PostgreSQL/MySQL em containers

### Automação de Workflows  
- **Ferramenta**: N8N (em avaliação)  
- **Objetivo**: Automação de processos de negócio

### Vector Database  
- **Escolha**: Qdrant  
- **Objetivo**: Armazenamento de embeddings para AI/ML

---

## PRÓXIMOS PASSOS POTENCIAIS

*Esta seção será atualizada conforme o projeto avança*

1. **Fase Atual**: Configuração do workspace Perplexity para SSOT  
2. **Fases Futuras**:  
   - Definir arquitetura detalhada do mywai  
   - Implementar protótipo de workflow visual  
   - Integrar primeiro LLM via MCP  
   - Testar orquestração multi-modelo

---

## NOTAS PARA O ASSISTENTE

**Ao consultar este arquivo:**  
- Utilize como referência principal para compreender o contexto do projeto  
- Não considere tecnologias além das listadas aqui  
- Pergunte antes de sugerir alterações no stack  
- Mantenha alinhamento com a abordagem de faseamento sem prazos fixos

**Para atualizar este arquivo:**  
- Informe quando houver novas decisões técnicas importantes  
- Proponha adições baseadas em conversas com evidências claras  
- Preserve a estrutura e formatação consistentes

---

**Última Atualização**: 16/11/2025 19:09 (ID: 161125-190900)  
**Status**: SSOT Ativo