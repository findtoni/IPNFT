// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import { MyToken } from "../src/MyToken.sol";
import { IPNFT } from "../src/IPNFT.sol";
import { SchmackoSwap } from "../src/SchmackoSwap.sol";
import { Mintpass } from "../src/Mintpass.sol";
import { UUPSProxy } from "../src/UUPSProxy.sol";

contract UpgradeImplementation is Script {
    function run() public {
        vm.startBroadcast();
        address proxyAddr = vm.envAddress("PROXY_ADDRESS");

        //this is not exactly true, it's the old implementation that we don't know here anymore
        //see IPNFTUpgrades.t.sol:testUpgradeContract
        IPNFT proxyIpnft = IPNFT(address(proxyAddr));
        //create a new implementation
        IPNFT newImpl = new IPNFT();
        proxyIpnft.upgradeTo(address(newImpl));

        console.log("new impl %s", address(newImpl));

        vm.stopBroadcast();
    }
}
