// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISwapRouter} from "./interfaces/ISwapRouter.sol";
import {INonfungiblePositionManager} from "./interfaces/INonfungiblePositionManager.sol";
import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";

contract UniswapParameter {
    ISwapRouter public immutable swapRouter;
    INonfungiblePositionManager public immutable nonfungiblePositionManager;

    constructor(
        ISwapRouter _swapRouter,
        INonfungiblePositionManager _nonfungiblePositionManager
    ) {
        swapRouter = _swapRouter;
        nonfungiblePositionManager = _nonfungiblePositionManager;
    }

    /* -------------------------------------------------------------------------- */
    /*                               TOKEN APPROVALS                              */
    /* -------------------------------------------------------------------------- */

    function approveSwapRouter(address token, uint amount) external {
        SafeTransferLib.safeApprove(token, address(swapRouter), amount);
    }

    function approvePositionManager(address token, uint amount) external {
        SafeTransferLib.safeApprove(
            token,
            address(nonfungiblePositionManager),
            amount
        );
    }

    /* -------------------------------------------------------------------------- */
    /*                              SWAP EXACT INPUTS                             */
    /* -------------------------------------------------------------------------- */

    function swapExactInputSingle(
        ISwapRouter.ExactInputSingleParams memory params
    ) external returns (uint256) {
        // optionally handle validation
        return swapRouter.exactInputSingle(params);
    }

    function swapExactInputMultihop(
        ISwapRouter.ExactInputParams memory params
    ) external returns (uint256) {
        // optionally handle validation
        return swapRouter.exactInput(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                             SWAP EXACT OUTPUTS                             */
    /* -------------------------------------------------------------------------- */

    function swapExactOutputSingle(
        ISwapRouter.ExactOutputSingleParams memory params
    ) external returns (uint256) {
        // optionally handle validation
        return swapRouter.exactOutputSingle(params);
    }

    function swapExactOutputMultihop(
        ISwapRouter.ExactOutputParams memory params
    ) external returns (uint256) {
        // optionally handle validation
        return swapRouter.exactOutput(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                             LIQUDITY PROVISION                             */
    /* -------------------------------------------------------------------------- */

    function mintLiquidityPosition(
        INonfungiblePositionManager.MintParams memory params
    )
        external
        returns (
            uint256 tokenId,
            uint128 liquidity,
            uint256 amount0,
            uint256 amount1
        )
    {
        // optionally handle validation
        return nonfungiblePositionManager.mint(params);
    }

    function collectLiquidityFees(
        INonfungiblePositionManager.CollectParams memory params
    ) external returns (uint256 amount0, uint256 amount1) {
        // optionally handle validation
        return nonfungiblePositionManager.collect(params);
    }

    function increaseLiquidity(
        INonfungiblePositionManager.IncreaseLiquidityParams memory params
    ) external returns (uint128 liquidity, uint256 amount0, uint256 amount1) {
        // optionally handle validation
        return nonfungiblePositionManager.increaseLiquidity(params);
    }

    function decreaseLiquidity(
        INonfungiblePositionManager.DecreaseLiquidityParams memory params
    ) external returns (uint256 amount0, uint256 amount1) {
        // optionally handle validation
        return nonfungiblePositionManager.decreaseLiquidity(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                               ERC721 RECEIVER                              */
    /* -------------------------------------------------------------------------- */

    function onERC721Received(
        address operator,
        address,
        uint256 tokenId,
        bytes calldata
    ) external returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
