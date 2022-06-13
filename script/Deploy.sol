// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.13;

import "src/MorphoToken.sol";
import "forge-std/Script.sol";

contract Deploy is Script {
  address constant owner = address(0x0);

  function run() external {
    vm.startBroadcast();
    MorphoToken token = new MorphoToken(
      msg.sender
    );
    token.setRoleCapability(0,address(token),Token.transfer.selector,true);
    token.setRoleCapability(0,address(token),Token.transferFrom.selector,true);
    token.setRoleCapability(1,address(token),Token.mint.selector,true);

    token.setOwner(owner);
    vm.stopBroadcast();
  }
}