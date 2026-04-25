import { network } from "hardhat";

const { ethers } = await network.create({
  network: "sepolia",
  chainType: "l1",
});

async function main() {
  const Token = await ethers.getContractFactory("MyToken");
  const token = await Token.deploy();
  await token.waitForDeployment();

  console.log("Token:", await token.getAddress());

  const NFT = await ethers.getContractFactory("MyNFT");
  const nft = await NFT.deploy();
  await nft.waitForDeployment();

  console.log("NFT:", await nft.getAddress());

  const Staking = await ethers.getContractFactory("Staking");
  const staking = await Staking.deploy(await token.getAddress());
  await staking.waitForDeployment();

  console.log("Staking:", await staking.getAddress());

  const DAO = await ethers.getContractFactory("SimpleDAO");
  const dao = await DAO.deploy(await token.getAddress());
  await dao.waitForDeployment();

  console.log("DAO:", await dao.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});