const hre= require("hardhat");

async function main() {
  const [owner] = await ethers.getSigners();
  const Token = await hre.ethers.getContractFactory("NFT");
  
  //Deploy
  const token = await Token.deploy();
  await token.deployed();

  
  console.log('owner address: ${owner.address}');

  //Mint 2 tokens
  await token.safeMint(owner.address, { 
    value: ethers.utils.parseEther("0.001"),
  });
  await token.safeMint (owner.address, {
    value: ethers.utils.parseEther("0.001"),
  });

  console.log(`Deployed token address: ${token.address}`);

  const WAIT_BLOCK_CONFIRMATIONS = 6;
  await token.deployTransaction.wait(WAIT_BLOCK_CONFIRMATIONS);

  console.log(`Contrct deployed to ${token.address} on ${network.name}`);

  console.log(`Verifying contract on Etherscan...`);

  await run(`verify:verify`, {
    address: token.address,
    constructorArguments: [],
  });
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});