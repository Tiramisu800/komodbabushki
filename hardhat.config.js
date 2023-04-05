require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config()

const BNBT_PRIVATE_KEY = process.env.BNBT_PRIVATE_KEY
const BNBT_RPC_URL = process.env.BNBT_RPC_URL;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    bnbtestnet: {
      url:BNBT_RPC_URL,
      accounts:[BNBT_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: "Z6H2Q2ND5VCIDXIBETK9RDDRGYR4Z73VKX", //Your Etherscan API key
  },
};
