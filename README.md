# OTClientV8 - AI Integration Project

Este repositório é um *fork* do [OTClientV8](https://github.com/OTCV8/otclientv8) e serve como base para um projeto de estudo e desenvolvimento de Inteligência Artificial aplicada a jogos MMORPG.

**Status atual:** 🚧 Fase Inicial 

---

## Objetivo do Projeto

A meta é modificar o cliente de Tibia (OTClient) para integrar uma interface de chat conectada a uma **LLM (Large Language Model)** via um microserviço externo.

O projeto visa explorar:
1.  Modificação de interface (UI/UX) em Lua/OTUI.
2.  Comunicação HTTP entre Cliente de jogo e API externa.
3.  Desenvolvimento de Backend em Python (FastAPI).
4.  Engenharia de Prompt para NPCs ou Assistentes de Jogo.

---

## 🏗️ Arquitetura Planejada

O sistema será desenvolvido em duas camadas:

1.  **Frontend (Cliente):**
    * O OTClient será modificado para incluir um painel lateral dedicado.
    * Um novo módulo (`client_aichat`) será criado para capturar inputs do usuário.

2.  **Backend (Servidor de IA):**
    * Uma API Python rodará localmente.
    * Responsável por receber o texto do jogo, processar em uma IA e devolver a resposta.

---

## Créditos

* Projeto Base: [OTClientV8](https://github.com/OTCV8/otclientv8)
* Desenvolvimento da Integração IA: **VictorHugo-Neo**