// scripts/deploy.js
require("@nomiclabs/hardhat-ethers");

async function main() {

	const CoinToss = await ethers.getContractFactory("CoinToss");
	console.log("Deploying...");
	const box = await CoinToss.deploy("0xCE301566b668E7Fa0F207655671f873370b925a3");
	console.log("COINTOSS :", box.address);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
