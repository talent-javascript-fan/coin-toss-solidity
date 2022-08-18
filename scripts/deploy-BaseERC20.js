// scripts/deploy.js
require("@nomiclabs/hardhat-ethers");

async function main() {

	const BaseERC20 = await ethers.getContractFactory("BaseERC20");
	console.log("Deploying BaseERC20...");
	const box = await BaseERC20.deploy();
	console.log("BaseERC20 :", box.address);
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
