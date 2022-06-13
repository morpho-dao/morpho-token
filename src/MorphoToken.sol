// SPDX-License-Identifier: GNU AGPLv3
pragma solidity ^0.8.13;

import "@mangrovedao/semitransferable-token/Token.sol";

/// @title MorphoToken.
/// @author Morpho Association.
/// @custom:contact security@morpho.xyz
/// @notice Morpho's token contract.
contract MorphoToken is Token {

  /// @notice Constructs Morpho's token contract.
  /// @param _owner The address of the owner (Morpho DAO).
  constructor(address _owner) Token("Morpho Token", "MORPHO", 18, _owner) {}
}
