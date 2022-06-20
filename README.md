# Morpho Token

The Morpho Token contract inherits the semi-transferable token pattern built by [@adhusson](https://github.com/adhusson), a contributor of the Morpho DAO and a core contributor at Mangrove DAO. Please, refer to the [semi-transferable repository](https://github.com/mangrovedao/semitransferable-token) to learn more about its functionalities and specificities.

## Morpho token’s lifecycle

The Morpho token’s lifecycle can be split into three main stages. Note that token holders can burn their tokens at any stage.

### 1. Token deployment and minting

At deployment, 1 billion tokens are minted by the owner: the Morpho DAO. At this point, the token is non-transferable by default.

### 2. Transferability whitelisting

The DAO can decide on contracts that will be allowed to transfer tokens. For example, these allowed contracts could be handling Morpho token distributions like the `RewardsDistributor` and the `IncentivesVault` directly built in the [morpho-core-v1](https://github.com/morphodao/morpho-core-v1) repository.

### 3. Fully transferable

The Morpho DAO can then decide to allow anyone to transfer freely their tokens by setting:
```solidity
token.setPublicCapability(Token.transfer.selector, true);
token.setPublicCapability(Token.transferFrom.selector, true);
```

## Setup

After cloning the repo, run:
```bash
git submodule update --init --recursive
```

Tests can be run using:
```bash
forge test
```

## Audits

The [semi-transferable repository](https://github.com/mangrovedao/semitransferable-token) has been audited by Omniscia. The audit report can be found [here](https://omniscia.io/morpho-specialized-token/).