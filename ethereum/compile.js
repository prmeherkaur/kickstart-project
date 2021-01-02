const path=require('path');
const solc=require('solc');
const fs=require('fs-extra'); //to have access to local file system of device
const buildPath=path.resolve(__dirname,'build'); //accessing build folder
fs.removeSync(buildPath); //deleting build folder (to remove any prev build data)
const campaignPath=path.resolve(__dirname,'contracts','campaign.sol'); 
const source=fs.readFileSync(campaignPath,'utf8');
const output=solc.compile(source,1).contracts; //compile both the contracts and storing the output that contains their compiled version
//output contains compiled version of both campaign and factory contract
// Now to write output to build directory we need build directory so we create that again 
fs.ensureDirSync(buildPath);
//separating the two contracts in output and writing them to separate files in build
for(let contract in output){
    fs.outputJsonSync(
        path.resolve(buildPath,contract.replace(':', '') + '.json'),
        output[contract]
    );
}
// we are doing all this to ensure that  we dont have to compile both contracts everytime we need access to one of them
