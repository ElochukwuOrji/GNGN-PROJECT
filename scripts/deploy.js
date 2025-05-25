const hre = require("hardhat");

async function main() {
    // Get signers (ensure your .env has enough funded accounts)
    const [deployer, owner1, owner2] = await hre.ethers.getSigners();
    console.log("Deploying with account:", deployer.address);
    
    // 1. Deploy MultiSig Wallet
    const MultiSigWallet = await hre.ethers.getContractFactory("MultiSigWallet");
    const multiSig = await MultiSigWallet.deploy(
        [deployer.address, owner1.address, owner2.address], // Owners
        2 // Confirmations required
    );
    await multiSig.waitForDeployment();
    const multiSigAddress = await multiSig.getAddress();
    console.log("MultiSig deployed to:", multiSigAddress);

    // 2. Deploy GNGN Token
    const GNGN = await hre.ethers.getContractFactory("GNGN");
    const gngn = await GNGN.deploy(multiSigAddress); // Pass MultiSig as governor
    await gngn.waitForDeployment();
    const gngnAddress = await gngn.getAddress();
    console.log("GNGN token deployed to:", gngnAddress);

    console.log("\nDeployment complete!");
    console.log("MultiSig Wallet:", multiSigAddress);
    console.log("GNGN Token:", gngnAddress);
}

main().catch((error) => {
    console.error("Deployment failed:", error);
    process.exitCode = 1;
});