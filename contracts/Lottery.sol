pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
          manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint){
        return uint(keccak256(block.difficulty, now,players));// random
    }

    function pickWinner() public restricted {
      //it is commneted after adding modifier // require(msg.sender == manager); //only manager can pick the winner

        uint index = random() % players.length;
        players[index].transfer(this.balance);// address of the players
        players = new address[](0); //resetting contract state by emptying players this will create dynamics array of zero inilitiaze
    }

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns(address[]){
        return players;

    }


}
