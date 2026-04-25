# 🚀 Simple Web3 Protocol

## 📌 Descrição
Projeto Aula  Residência TIC29 - Web3

Este projeto consiste no desenvolvimento de um protocolo Web3 básico utilizando Solidity e Hardhat.

O sistema implementa funcionalidades essenciais do ecossistema blockchain:

* Token ERC-20
* NFT ERC-721
* Staking com recompensa
* Governança simples (DAO)

---

## ⚙️ Tecnologias Utilizadas

* Solidity ^0.8.x
* Hardhat
* OpenZeppelin
* Ethers.js
* Sepolia Testnet

---

## 🧱 Arquitetura do Projeto

O projeto é composto por 4 contratos principais:

### 🪙 Token (ERC-20)

* Nome: Tic29
* Símbolo: TIC29
* Responsável por representar o ativo principal do sistema

### 🖼️ NFT (ERC-721)

* Permite a criação de tokens únicos (mint)

### 💰 Staking

* Permite depósito de tokens
* Recompensa fixa de 10%

### 🗳️ DAO

* Sistema simples de votação baseado em tokens

---

## 🚀 Deploy (Sepolia)

* Token: 0x612141d3Bc40D788D5817d6f515868F8Ca383c43
* NFT: 0x86B9f2BB1B8a78fd8356054Bc256e1D7627CC8F1
* Staking: 0x44F1795bB69Ac835185E96a9d317F9785029A381
* DAO: 0xb4C5a7d16d081054CBA79DCF0e108FcFDB438f43

---

## 🧪 Funcionalidades Testadas

* ✔️ Aprovação de tokens (approve)
* ✔️ Staking de tokens
* ✔️ Retirada com recompensa
* ✔️ Mint de NFT
* ✔️ Votação na DAO

---

## ▶️ Como executar o projeto

```bash
npm install
npx hardhat compile
npx hardhat run scripts/deploy.ts --network sepolia
```

---

## 🔐 Segurança

* Uso de OpenZeppelin (contratos auditados)
* Solidity ^0.8.x (proteção contra overflow)
* Validações com require

---

## 🌐 Oráculos

A integração com oráculos pode ser realizada via Chainlink para consumo de dados externos. Nesta versão, a funcionalidade foi simplificada.

---

## 👨‍💻 Autor

Edu
https://www.linkedin.com/in/educarlos29/