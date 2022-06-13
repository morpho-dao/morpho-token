# Morpho Token

Morpho's token contract based on the [semitransferable token](https://github.com/mangrovedao/semitransferable-token) build by Mangrove DAO. Please, refer to this documentation to learn more about the functionalities of this token.

## Morpho token's life stages

The Morpho token's life can be splitted into 3 main stages described below.
Note that token holders can burn their own tokens at any stage.

### 1. Token deployment and minting

At deployment, 1B tokens will be minted by the owner (the Morpho DAO).
The token is non-transferable by default.

### 2. Transferability whitelisting

Some contracts will be allowed to transfer tokens. These whitelisted contracts are most likely those handling Morpho's rewards like the `RewardsDistributor` and the `IncentivesVault`.

### 3. Fully transferable

At one point, the Morpho DAO will allow anyone to freely transfer their tokens.

## Setup

After cloning the repo, run:
```bash
git submodule update --init --recursive
```

Tests can be run using:
```bash
forge test
```