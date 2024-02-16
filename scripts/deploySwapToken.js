const hre = require('hardhat');

async function main() {
  console.log("deploying...")
  const swapTokenContract = await hre.ethers.deployContract('SwapTokenContract');
  await swapTokenContract.waitForDeployment();
  console.log(`Contract deployed to ${swapTokenContract.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
