const hre = require("hardhat");

async function main() {
  const SubscriptionDAO = await hre.ethers.getContractFactory("SubscriptionDAO");
  const monthlyFeeInWei = hre.ethers.utils.parseEther("0.01");
  const subscriptionDAO = await SubscriptionDAO.deploy(monthlyFeeInWei);

  await subscriptionDAO.deployed();

  console.log("SubscriptionDAO deployed to:", subscriptionDAO.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Deployment error:", error);
    process.exit(1);
  });
