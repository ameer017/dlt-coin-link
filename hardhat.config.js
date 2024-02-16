require("@nomicfoundation/hardhat-toolbox");

// NEVER record important private keys in your code - this is for demo purposes
const SEPOLIA_TESTNET_PRIVATE_KEY =
  "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
const ARBITRUM_MAINNET_TEMPORARY_PRIVATE_KEY =
  "7ab481906471300a3982c4fd072e1c786237a1cf8d392c02a124de4f481b2c12";

/** @type import('hardhat/config').HardhatUserConfig */
import('hardhat/config.js').HardhatUserConfig 

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.24",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
        },
      },
    ],
  },
  networks: {
    hardhat: {
      chainId: 1337,
      port: 8545,
    },
    arbitrumSepolia: {
      url: "https://sepolia-rollup.arbitrum.io/rpc",
      chainId: 421614,
      accounts: [SEPOLIA_TESTNET_PRIVATE_KEY],
    },
    arbitrumOne: {
      url: "https://arb1.arbitrum.io/rpc",
      accounts: [ARBITRUM_MAINNET_TEMPORARY_PRIVATE_KEY],
    },
  },
};
