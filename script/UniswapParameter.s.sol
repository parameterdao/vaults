// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Script, console2} from "forge-std/Script.sol";

import "../src/parameters/uniswap3/UniswapSinglePair.sol";

contract CreateUniswapSinglePair is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address swapRouter = address(
            0xE592427A0AEce92De3Edee1F18E0157C05861564
        );
        address nonfungiblePositionManager = address(
            0xC36442b4a4522E871399CD717aBDD847Ab11FE88
        );
        // WETH
        address token0 = address(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
        // USDC
        address token1 = address(0xaf88d065e77c8cC2239327C5EDb3A432268e5831);

        UniswapSinglePair parameter = new UniswapSinglePair(
            swapRouter,
            nonfungiblePositionManager,
            token0,
            token1
        );

        vm.stopBroadcast();
    }
}
