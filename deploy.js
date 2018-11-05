const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 =  require('web3');
const {interface,bytecode} = require ('./compile');

const provider = new HDWalletProvider(
'flush armor antique shock east brother spider jealous six armor father upset',
'https://rinkeby.infura.io/v3/efbf49ec4a2244ea9f6188ee82704267'

);

const web3 = new Web3(provider);

const deploy = async () =>{
  const accounts = await web3.eth.getAccounts();
  console.log('Attempting to deploy from account ', accounts[0]);

  const result = await new web3.eth.Contract(JSON.parse(interface))
            .deploy({data:'0x'+bytecode})
            .send({gas: '1000000', from: accounts[0]});

  console.log('Contract deplouyed to ', result.options.address);

};

deploy();
