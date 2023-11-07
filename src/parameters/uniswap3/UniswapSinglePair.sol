// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ISwapRouter} from "./interfaces/ISwapRouter.sol";
import {INonfungiblePositionManager} from "./interfaces/INonfungiblePositionManager.sol";
import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";

contract UniswapParameter {
    ISwapRouter public immutable swapRouter;
    INonfungiblePositionManager public immutable nonfungiblePositionManager;

    address immutable token0;
    address immutable token1;

    constructor(
        ISwapRouter _swapRouter,
        INonfungiblePositionManager _nonfungiblePositionManager,
        address _token0,
        address _token1
    ) {
        swapRouter = _swapRouter;
        nonfungiblePositionManager = _nonfungiblePositionManager;
        token0 = _token0;
        token1 = _token1;
    }

    /* -------------------------------------------------------------------------- */
    /*                               TOKEN APPROVALS                              */
    /* -------------------------------------------------------------------------- */

    function approveSwapRouter(address token, uint amount) external {
        require(token == token0 || token == token1, "token not allowed");
        SafeTransferLib.safeApprove(token, address(swapRouter), amount);
    }

    function approvePositionManager(address token, uint amount) external {
        require(token == token0 || token == token1, "token not allowed");
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
        require(
            params.tokenIn == token0 || params.tokenIn == token1,
            "token not allowed"
        );
        require(
            params.tokenOut == token0 || params.tokenOut == token1,
            "token not allowed"
        );
        // optionally handle validation
        return swapRouter.exactInputSingle(params);
    }

    /* -------------------------------------------------------------------------- */
    /*                             SWAP EXACT OUTPUTS                             */
    /* -------------------------------------------------------------------------- */

    function swapExactOutputSingle(
        ISwapRouter.ExactOutputSingleParams memory params
    ) external returns (uint256) {
        // optionally handle validation
        require(
            params.tokenIn == token0 || params.tokenIn == token1,
            "token not allowed"
        );
        require(
            params.tokenOut == token0 || params.tokenOut == token1,
            "token not allowed"
        );
        return swapRouter.exactOutputSingle(params);
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
        require(
            params.token0 == token0 || params.token0 == token1,
            "token not allowed"
        );
        require(
            params.token1 == token0 || params.token1 == token1,
            "token not allowed"
        );
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
