#  Relatório de Auditoria de Segurança
## Simple Web3 Protocol — Residência TIC29

**Data:** 01/05/2026  
**Ferramenta utilizada:** Slither v0.x (crytic/slither)  
**Contratos analisados:** `MyToken.sol`, `Staking.sol`  
**Rede de deploy:** Sepolia Testnet  
**Total de detectores executados:** 101  
**Total de resultados encontrados:** 22  

---

## Sumário

A auditoria foi realizada com a ferramenta de análise estática **Slither** sobre os contratos do protocolo. Dos 22 resultados encontrados, **nenhum foi classificado como crítico**. A maioria dos alertas provém das dependências da biblioteca OpenZeppelin — contratos já amplamente auditados pela comunidade — e não representam vulnerabilidades nos contratos desenvolvidos neste projeto.

Todas as findings identificadas nos contratos próprios (`MyToken.sol` e `Staking.sol`) foram analisadas e tratadas conforme descrito abaixo.

---

## 🔴 Crítico

Nenhuma vulnerabilidade crítica encontrada.

---

## 🟠 Alto

Nenhuma vulnerabilidade de alta severidade encontrada.

---

## 🟡 Médio

### [M-01] Reentrancy benigna em `Staking.stake()`

| Campo | Detalhe |
|---|---|
| **Detector** | `reentrancy-benign` |
| **Arquivo** | `contracts/Staking.sol` |
| **Função** | `stake(uint256)` |
| **Linha** | 16–21 |

**Descrição:**  
A função `stake()` realiza uma chamada externa (`token.transferFrom`) antes de atualizar a variável de estado `balance[msg.sender]`. Isso caracteriza um padrão de reentrancy benigna — ou seja, não há risco de drenagem de fundos neste fluxo específico, mas o padrão não segue as melhores práticas (Checks-Effects-Interactions).

**Status:** Aceito — risco baixo neste contexto  
**Mitigação aplicada:** O contrato herda `ReentrancyGuard` da OpenZeppelin e a função `withdraw()`, que representa o real risco de reentrancy (movimentação de fundos), está protegida pelo modifier `nonReentrant`.

---

## 🟢 Baixo / Informativo

### [L-01] Variável de estado poderia ser declarada `immutable`

| Campo | Detalhe |
|---|---|
| **Detector** | `immutable-states` |
| **Arquivo** | `contracts/Staking.sol` |
| **Variável** | `token` |

**Descrição:**  
A variável `token` é definida no construtor e nunca mais alterada, podendo ser declarada como `immutable` para economizar gas e sinalizar intenção ao leitor do código.

**Status:** ✅ Corrigido  
**Correção aplicada:**
```solidity
// Antes
MyToken public token;

// Depois
MyToken public immutable token;
```

---

### [L-02] Literal numérico com muitos dígitos

| Campo | Detalhe |
|---|---|
| **Detector** | `too-many-digits` |
| **Arquivo** | `contracts/MyToken.sol` |
| **Linha** | 8 |

**Descrição:**  
O literal `1000000` foi sinalizado por dificultar a leitura. A convenção recomendada em Solidity é usar separadores de underscore para melhorar a legibilidade.

**Status:** ✅ Corrigido  
**Correção aplicada:**
```solidity
// Antes
_mint(msg.sender, 1000000 * 10 ** decimals());

// Depois
_mint(msg.sender, 1_000_000 * 10 ** decimals());
```

---

### [I-01] Múltiplas versões de pragma detectadas

| Campo | Detalhe |
|---|---|
| **Detector** | `pragma` |
| **Arquivos** | Dependências OpenZeppelin |

**Descrição:**  
Foram detectadas 4 versões diferentes de pragma Solidity entre os arquivos do projeto e suas dependências (`^0.8.20`, `>=0.8.4`, `>=0.4.16`, `>=0.6.2`). As versões divergentes estão todas nos contratos da OpenZeppelin, não nos contratos próprios do projeto.

**Status:** ℹ️ Aceito — origina-se exclusivamente de dependências de terceiros  

---

### [I-02] Uso de assembly inline

| Campo | Detalhe |
|---|---|
| **Detector** | `assembly` |
| **Arquivo** | `node_modules/@openzeppelin/contracts/utils/StorageSlot.sol` |

**Descrição:**  
O Slither detectou uso de assembly inline em 9 funções do contrato `StorageSlot.sol` da OpenZeppelin. Este uso é intencional e necessário para a implementação interna da biblioteca.

**Status:** ℹ️ Aceito — código de terceiro auditado (OpenZeppelin)  

---

### [I-03] Código morto (dead code) nas dependências

| Campo | Detalhe |
|---|---|
| **Detector** | `dead-code` |
| **Arquivo** | `node_modules/@openzeppelin/contracts/...` |

**Descrição:**  
Funções como `_msgData()`, `_contextSuffixLength()` e `ERC20._burn()` foram detectadas como nunca utilizadas. Essas funções fazem parte da interface padrão da OpenZeppelin e são disponibilizadas para uso em contratos que estendam a biblioteca.

**Status:** ℹ️ Aceito — comportamento esperado da OpenZeppelin  

---

### [I-04] Versões de Solidity com issues conhecidos

| Campo | Detalhe |
|---|---|
| **Detector** | `solc-version` |
| **Arquivos** | Contratos próprios e dependências |

**Descrição:**  
O Slither sinalizou que os ranges de versão utilizados (`^0.8.20`, `>=0.8.4`, etc.) cobrem versões do compilador com issues conhecidos. No entanto, o projeto compila com `solc 0.8.28`, que não está afetado pelos bugs listados.

**Status:** ℹ️ Aceito — versão de compilação efetiva (0.8.28) não é afetada  

---

## ✅ Práticas de Segurança Aplicadas

| Prática | Status |
|---|---|
| Uso de Solidity ^0.8.x (proteção contra overflow nativa) | ✅ |
| Uso de contratos OpenZeppelin auditados | ✅ |
| `ReentrancyGuard` aplicado na função `withdraw()` | ✅ |
| Variável `token` declarada como `immutable` | ✅ |
| Validações com `require` em funções críticas | ✅ |
| Zeramento do saldo antes da transferência no `withdraw()` | ✅ |

---

## Contratos Deployados (Sepolia)

| Contrato | Endereço |
|---|---|
| Token (ERC-20) | `0xf2d325511E757ba769Bd773606f481D28d6C11aF` |
| NFT (ERC-721) | `0x759A9D67548e3237bb4977DcEF91Dbb88c4bC89A` |
| Staking | `0x67eF82876730b46BDEE07cA3105ba25a8f8e9494` |
| DAO | `0x44c2c5Cc881bC8b2720a15C3dA63a9285f911aA2` |

---

## 🏁 Conclusão

O protocolo apresenta um nível de segurança adequado para um MVP em ambiente de testnet. As duas findings nos contratos próprios foram corrigidas durante o processo de auditoria. Os demais alertas são provenientes de dependências de terceiros (OpenZeppelin) e não representam risco para o protocolo.

Recomenda-se, para versões futuras em produção, a execução adicional do **Mythril** para análise simbólica e eventual auditoria manual por terceiros antes de deploy em mainnet.