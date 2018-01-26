pragma solidity ^0.4.0;


contract    vote {
    
    address public owner;
    modifier isowner(){
        if (msg.sender != owner){
            revert();}
        _;
        
    }
    function test() public{
        owner = msg.sender;
    }

    mapping (bytes32=>uint) candidats;
    mapping (address=>uint) votants ;
    address []public votantsAddress;

    function ajouterVotant(address _address) public{
        votantsAddress.push(_address);
    }

    function donnedroitdevote() public{ 
        for (uint i = 0; i < votantsAddress.length; i ++) 
        {
            votants[votantsAddress[i]]=1;   
        }
        
    }
    function vote(address _address, bytes32 choix) public{
        if (votants[_address]==1)
        {
            candidats[choix]+=1;
            votants[_address]=0;
        }
    }
    function kill() public{
        delete owner;
        delete candidats;
        for (uint i = 0; i < votantsAddress.length; i ++) 
        {
            delete votants[votantsAddress[votantsAddress.length]];
            delete votantsAddress[votantsAddress.length];
            votantsAddress.length--;
        }

        selfdestruct(msg.sender);
    }
}