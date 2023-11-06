// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISwapRouter} from "v3-periphery/interfaces/ISwapRouter.sol";
import {INonfungiblePositionManager} from "v3-periphery/interfaces/INonfungiblePositionManager.sol";
import {TransferHelper} from "v3-periphery/libraries/TransferHelper.sol";

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
        // Approve the router to spend DAI.
        TransferHelper.safeApprove(token, address(swapRouter), amount);
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
}
