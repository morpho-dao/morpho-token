// SPDX-License-Identifier: GNU AGPLv3
pragma solidity ^0.8.13;

import "@semitransferable-token/Token.sol";

/// @title MorphoToken.
/// @author Morpho Association.
/// @custom:contact security@morpho.xyz
/// @notice Morpho token contract.
contract MorphoToken is Token {

    /// @notice Constructs Morpho token contract.
    /// @param _owner The address of the owner (Morpho Association -> Morpho DAO).
    constructor(address _owner) Token("Morpho Token", "MORPHO", 18, _owner) {
        // Before transferring ownership to the DAO, the Morpho Association (ADMO) mints 0.2B of Morpho tokens.
        // Those tokens are to be kept by the association or distributed to contributors and investors.
        // The 0.8B Morpho tokens left can be minted by the DAO once it has ownership.
        _mint(_owner, 0.2e9 ether);
    }
}
