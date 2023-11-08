// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

import {Script, console2} from "forge-std/Script.sol";

import "../src/Vault.sol";
import {UniswapSinglePair} from "../src/parameters/uniswap3/UniswapSinglePair.sol";

contract CreateVault is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Vault vault = new Vault(
            address(0x6168F08D6bDcb4F79F713cE441ECC8D4E42ef9e7)
        );

        vm.stopBroadcast();
    }
}

contract AddRoutes is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        Vault vault = Vault(
            payable(0xfa0F0978b43b54c5AeD816D2a324304829934e1b)
        );

        // CHANGE ME!!!!
        address permissionsContract = address(
            0xd6d650Bef12989926b2d5ECb62DD98f509e8da1d
        );

        bytes4[] memory FUNCTION_SELECTORS = new bytes4[](9);
        FUNCTION_SELECTORS[0] = UniswapSinglePair
            .approvePositionManager
            .selector;
        FUNCTION_SELECTORS[1] = UniswapSinglePair.approveSwapRouter.selector;
        FUNCTION_SELECTORS[2] = UniswapSinglePair.swapExactInputSingle.selector;
        FUNCTION_SELECTORS[3] = UniswapSinglePair
            .swapExactOutputSingle
            .selector;
        FUNCTION_SELECTORS[4] = UniswapSinglePair
            .mintLiquidityPosition
            .selector;
        FUNCTION_SELECTORS[5] = UniswapSinglePair.collectLiquidityFees.selector;
        FUNCTION_SELECTORS[6] = UniswapSinglePair.increaseLiquidity.selector;
        FUNCTION_SELECTORS[7] = UniswapSinglePair.decreaseLiquidity.selector;
        FUNCTION_SELECTORS[8] = UniswapSinglePair.onERC721Received.selector;

        address[] memory TARGET_CONTRACTS = new address[](9);
        TARGET_CONTRACTS[0] = permissionsContract;
        TARGET_CONTRACTS[1] = permissionsContract;
        TARGET_CONTRACTS[2] = permissionsContract;
        TARGET_CONTRACTS[3] = permissionsContract;
        TARGET_CONTRACTS[4] = permissionsContract;
        TARGET_CONTRACTS[5] = permissionsContract;
        TARGET_CONTRACTS[6] = permissionsContract;
        TARGET_CONTRACTS[7] = permissionsContract;
        TARGET_CONTRACTS[8] = permissionsContract;

        vault.addRoutes(FUNCTION_SELECTORS, TARGET_CONTRACTS);

        vm.stopBroadcast();
    }
}
