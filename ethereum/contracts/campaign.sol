pragma solidity ^0.4.17;
contract Factory{
    address[] public deployedCampaigns;
    
    function createCampaign(uint min) public{
        address newCampaign= new Campaign(min,msg.sender);
        deployedCampaigns.push(newCampaign);
    }
    
    function getDeployedCampaigns() public view returns (address[]){
        return deployedCampaigns;
    }
}
contract Campaign{
    struct Request{
        string description;
        uint value;
        address recipient;
        bool complete;
        mapping(address=>bool) approvals;
        uint approvalCount;
    }
    address public manager;
    uint public minContribution;
    mapping(address=>bool) public approvers;
    uint approversCount;
    Request[] public requests;
    modifier restricted(){
        require(msg.sender==manager);
        _;
    }
    constructor(uint min, address user) public{
        manager=user;
        minContribution=min;
    }
    function contribute() public payable{
        require(msg.value>minContribution);
        approvers[msg.sender]=true;
        approversCount++;
    }
    function createRequest(string description,uint value,address recipient) public restricted
    {
        Request memory newRequest=Request({
            description:description,
            value:value,
            recipient:recipient,
            complete:false,
            approvalCount:0
        });
        requests.push(newRequest);
    } 
    function approveRequest(uint index) public{
        require(approvers[msg.sender]);
        require(!requests[index].approvals[msg.sender]);
        requests[index].approvals[msg.sender]=true;
        requests[index].approvalCount++;
        
    }
    function finalizeRequest(uint index) public restricted{
        Request storage request=requests[index];
        require(!request.complete);
        require(request.approvalCount>(approversCount/2));
        request.recipient.transfer(request.value);
        request.complete=true;
    }
}