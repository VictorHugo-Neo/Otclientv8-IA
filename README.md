# Client - Tibia AI (OTClientV8 Mod)

Este repositório contém o **Cliente de Jogo** do projeto Tibia IA. Ele é um fork do [OTClientV8](https://github.com/OTCV8/otclientv8) modificado para incluir interfaces de interação com Inteligência Artificial.

A principal modificação é a inclusão de um painel lateral e módulos de chat que se comunicam com uma API externa.

---

## Ecossistema do Projeto

Este cliente é a "visão" e a "fala" do sistema. Ele faz parte de uma arquitetura de 3 pilares:

| Componente | Repositório | Função |
| :--- | :--- | :--- |
| **Client** | **[Você está aqui]** | Interface gráfica, Chat, Input do Jogador. |
| **Game Server** | [Tibia_ia](https://github.com/VictorHugo-Neo/Tibia_ia) | Regras do jogo, física, monstros e banco de dados. |
| **AI Brain** | *Tibia_AI_Brain* (Local/Privado) | Microserviço Python que processa a IA (LLM). |

---

## Funcionalidades Específicas

* **Layout Híbrido:** A tela do jogo (`gameMapPanel`) foi deslocada para a direita, criando um espaço dedicado à esquerda para ferramentas de IA.
* **Módulo `client_aichat`:** Uma janela de chat ancorada no novo painel esquerdo, projetada para enviar requisições HTTP para o microserviço de IA sem depender do chat padrão do jogo.

## Créditos

* Baseado no projeto [OTClientV8](https://github.com/OTCV8/otclientv8).
* Modificações de Interface e IA por **VictorHugo-Neo**.