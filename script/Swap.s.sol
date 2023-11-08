// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Script, console2} from "forge-std/Script.sol";

import "../src/parameters/uniswap3/UniswapSinglePair.sol";
import "../src/parameters/uniswap3/interfaces/ISwapRouter.sol";

interface v {
    function swapExactInputSingle(
        ISwapRouter.ExactInputSingleParams memory params
    ) external;
}

contract Approve is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        UniswapSinglePair vault = UniswapSinglePair(
            payable(0xfa0F0978b43b54c5AeD816D2a324304829934e1b)
        );

        address weth = address(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
        address usdc = address(0xaf88d065e77c8cC2239327C5EDb3A432268e5831);

        vault.approveSwapRouter(weth, type(uint).max);
        vault.approveSwapRouter(usdc, type(uint).max);

        vm.stopBroadcast();
    }
}

contract Swap is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        v vault = v(payable(0xfa0F0978b43b54c5AeD816D2a324304829934e1b));

        address weth = address(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);
        address usdc = address(0xaf88d065e77c8cC2239327C5EDb3A432268e5831);
        uint amountIn = 451891333259520;

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: weth,
                tokenOut: usdc,
                fee: 3000,
                recipient: address(0x6168F08D6bDcb4F79F713cE441ECC8D4E42ef9e7),
                deadline: block.timestamp + 100,
                amountIn: amountIn,
                amountOutMinimum: 847062,
                sqrtPriceLimitX96: 0
            });

        vault.swapExactInputSingle(params);
        vm.stopBroadcast();
    }
}
