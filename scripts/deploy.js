const hre = require('hardhat');

async function main() {
  console.log("deployin...")
  const dltAToken = await hre.ethers.deployContract('DLTAToken');
  await dltAToken.waitForDeployment();
  console.log(`Contract deployed to ${dltAToken.target}`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
