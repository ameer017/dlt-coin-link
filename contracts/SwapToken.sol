// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.24;
pragma abicoder v2;

import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);

    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);
}

contract SwapTokenContract {
    address public constant routerAddress =
        0xE592427A0AEce92De3Edee1F18E0157C05861564;

    ISwapRouter public immutable swapRouter = ISwapRouter(routerAddress);

    address public constant DLTA = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    address public constant USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

    IERC20 public dltToken = IERC20(DLTA);

    // For this example, we will set the pool fee to 0.3%.
    uint24 public constant poolFee = 3000;

    function swapExactInputSingle(
        uint256 amountIn
    ) external returns (uint256 amountOut) {
        dltToken.approve(address(swapRouter), amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: DLTA,
                tokenOut: USDT,
                fee: poolFee,
                recipient: address(this),
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        amountOut = swapRouter.exactInputSingle(params);
    }

    function swapExactOutputSingle(
        uint256 amountOut,
        uint256 amountInMaximum
    ) external returns (uint256 amountIn) {
        dltToken.approve(address(swapRouter), amountInMaximum);

        ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter
            .ExactOutputSingleParams({
                tokenIn: DLTA,
                tokenOut: USDT,
                fee: poolFee,
                recipient: address(this),
                deadline: block.timestamp,
                amountOut: amountOut,
                amountInMaximum: amountInMaximum,
                sqrtPriceLimitX96: 0
            });

        amountIn = swapRouter.exactOutputSingle(params);

        if (amountIn < amountInMaximum) {
            dltToken.approve(address(swapRouter), 0);
            dltToken.transfer(address(this), amountInMaximum - amountIn);
        }
    }
}
