pragma solidity >=0.6.6 < 0.8.0;
contract Lottery {
    address public manager; //เก็บ address ของคนที่ Deploy ไว้
    address [] public players; //เก็บ addressของคนที่เข้ามาเล่น
    address payable public winner; //เก็บคนชนะในรอบนั้น
    //payable คือสามารถโอนเงินมาให้คนๆนี้ได้
     
    constructor() public {
        manager = msg.sender;
    }// address ของคน deploy จะเป็น manager
    function getBalance() public view returns (uint) {
        address(this).balance;
    }
    function enter() public payable {
        require (msg.value >= 0.01 ether);
        players.push(msg.sender);
    }//คนที่จะเล่นจะต้องจ่ายเงิน เงื่อนไขอย่างน้อย 0.01
    function random() private view returns (uint) {
        bytes memory val;
        val = abi.encodePacked(block.difficulty, now, players);
        return uint (keccak256(val));
    }//จะให้เลขมหนึ่งตัว
    
    function pickWinner() public checkForOnlyManager {
        uint index = random() % players.length; 
        // address payable winner;
        winner = payable (players[index]);
        winner.transfer(address(this).balance);//เงินจะไปรวมที่สามาร์คอนแทรคไม่ได้เข้าบัญชีใครแต่พอชนะจะทำการโอนเงินไปให้ผู้ชนะ
        //clear array for next round
        players = new address[](0); //เริ่มต้นใหม่
    } 
    
     modifier checkForOnlyManager { //คนกดปุุ่มจะต้องเป็น manager เท่านั้น
        require (msg.sender == manager);
        _;  
    }
    
    function getPlayers() public view returns (address[] memory) {
        return players;
    }
}