// const Dai = artifacts.require("Dai");
// const TransferWithDai = artifacts.require("TransferWithDai");
const Auction = artifacts.require("Auction");

const startDateString = '2021/12/12';
const endDateString = '2025/12/12';


module.exports = async function (deployer, _network, accounts) {
//   await deployer.deploy(Dai);
//   const dai = await Dai.deployed();
//   await deployer.deploy(TransferWithDai, dai.address);
//   const transferwithdai = await TransferWithDai.deployed();


//   await dai.faucet(transferwithdai.address, 100);
//   await transferwithdai.foo(accounts[1], 100);

//   const balance0 = await dai.balanceOf(transferwithdai.address);
//   const balance1 = await dai.balanceOf(accounts[1]);

//   console.log('Balance0: ',balance0.toString());
//   console.log('Balance1: ',balance1.toString());


  // Deploy
  await deployer.deploy(Auction);
  const auction = await Auction.deployed();

  const startDateString = '2021/12/12';
  const endDateString = '2025/12/12';
  
  const uintStartDate = Math.round(new Date(startDateString).getTime()/1000);
  const uintEndDate = Math.round(new Date(endDateString).getTime()/1000);

  await auction.createAuction(accounts[1], 1, uintStartDate, uintEndDate, "");

  // Get back the auction start date and end date and print in string
  const contractStartDateUnix = await auction.startTimestamp();
  const contractEndDateUnix = await auction.endTimestamp();

  const contractStartDate = new Date(contractStartDateUnix*1000).toLocaleString()
  const contractEndDate = new Date(contractEndDateUnix*1000).toLocaleString()

  console.log('Start: ', contractStartDate);
  console.log('End: ', contractEndDate);
};
