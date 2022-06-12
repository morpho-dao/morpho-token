// SPDX-License-Identifier: GNU AGPLv3
pragma solidity ^0.8.13;

import "lib/mangrovedao/semitransferable-token/src/Token.sol";

contract MorphoToken is Token {
	constructor(address _owner) Token("Morpho Token", "MORPHO", 18, _owner) {}
}
