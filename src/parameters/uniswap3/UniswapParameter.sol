// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISwapRouter} from "v3-periphery/interfaces/ISwapRouter.sol";
import {INonfungiblePositionManager} from "v3-periphery/interfaces/INonfungiblePositionManager.sol";
import {TransferHelper} from "v3-periphery/libraries/TransferHelper.sol";
import {IERC721Receiver} from "openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol";

contract UniswapParameter is IERC721Receiver {
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

    function approveSwapRouter(address token, uint amount) {
        TransferHelper.safeApprove(token, address(swapRouter), amount);
    }

    function approvePositionManager(address token, uint amount) {
        TransferHelper.safeApprove(
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
    ) returns (uint256) {
        // optionally handle validation
        return swapRouter.exactInputSingle(params);
    }

    function swapExactInputMultihop(
        ISwapRouter.ExactInputParams memory params
    ) returns (uint256) {
        // optionally handle validation
        return swapRouter.exactInput(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                             SWAP EXACT OUTPUTS                             */
    /* -------------------------------------------------------------------------- */

    function swapExactOutputSingle(
        ISwapRouter.ExactOutputSingleParams memory params
    ) returns (uint256) {
        // optionally handle validation
        return swapRouter.exactOutputSingle(params);
    }

    function swapExactOutputMultihop(
        ISwapRouter.ExactOutputParams memory params
    ) returns (uint256) {
        // optionally handle validation
        return swapRouter.exactOutput(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                             LIQUDITY PROVISION                             */
    /* -------------------------------------------------------------------------- */

    function mintLiquidityPosition(
        INonfungiblePositionManager.MintParams memory params
    )
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
    ) returns (uint256 amount0, uint256 amount1) {
        // optionally handle validation
        return nonfungiblePositionManager.collect(params);
    }

    function increaseLiquidity(
        INonfungiblePositionManager.IncreaseLiquidityParams memory params
    ) returns (uint128 liquidity, uint256 amount0, uint256 amount1) {
        // optionally handle validation
        return nonfungiblePositionManager.increaseLiquidity(params);
    }

    function decreaseLiquidity(
        INonfungiblePositionManager.DecreaseLiquidityParams memory params
    ) returns (uint256 amount0, uint256 amount1) {
        // optionally handle validation
        return nonfungiblePositionManager.decreaseLiquidity(params);
    }
}
