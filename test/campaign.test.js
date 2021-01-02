const assert=require('assert');
const ganache=require('ganache-cli');
const Web3=require('web3');
const web3=new Web3(ganache.provider()); 
//acquiring the compiled contracts
const compiledFactory=require('../ethereum/build/Factory.json');
const compiledCampaign=require('../ethereum/build/Campaign.json');

let accounts,factory,campaignAddress,campaign;
//accounts is list of accounts that exist on the local ganache network
//factory is the deployed instance of factory that is to be used
beforeEach(async()=>{

    accounts=await web3.eth.getAccounts();
    //deploy an instance of factory on local network using compiled version previously acquired
    

});
