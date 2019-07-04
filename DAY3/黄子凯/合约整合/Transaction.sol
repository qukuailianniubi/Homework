pragma solidity >=0.4.22 <0.6.0;

import "./Market.sol";

contract Transaction is Market{
    struct traMessage{
        uint _id;
        uint transaction_id;
        address _from;
        address _to;
        uint pet_id;
        uint pet_value;
        string messageInfo;
        bool messageState;
        bool trial;
    }
 
    Transaction[] public transactions;
    traMessage[] public traMessages;
    

    event transferEvent(uint transaction_id,address _from ,address _to, uint pet_id,uint pet_value);
    event getPetEvent(uint pet_id,address _from);
    event correctEvent(uint transaction_id, string _messageInfo);
    event trialEvent(uint _id);

    function _transfer(address _from, address _to,uint pet_id,uint pet_value) private{
        require(_to!=0x0);
        require(balanceOf[_from]>=pet_value);
        require(pet_value>0);


            
            //转账
            uint sum = balanceOf[_from]+balanceOf[_to];
            balanceOf[_from]-=pet_value;
            balanceOf[_to]+=pet_value;
            assert(balanceOf[_from]+balanceOf[_to]==sum);
            
            //交易单生成
            uint transaction_id = transactions.push(Transaction(transactions.length,_from,_to,pet_id,pet_value))-1;
            emit transferEvent(transaction_id,_from,_to,pet_id,pet_value);
            
            //宠物拥有权转移
            petToOwner[pet_id]=_from;
            ownerPetCount[_from]++;
            ownerPetCount[_to]--;
            
            
            //上架状态更改
            pets[pet_id].pet_state = false;
            emit getPetEvent(pet_id,  _from);

    }
    
    function transfer(address _to,uint pet_id, uint pet_value) public {
        require(pets[pet_id].pet_state==true);
        _transfer(msg.sender,_to,pet_id,pet_value);
    }
    
    function checkTransfer(uint i) public view returns(uint transactionId,address _from, address _to, uint petId, uint petValue) {
            if(transactions[i]._from == msg.sender || transactions[i]._to == msg.sender){
                transactionId = transactions[i].transaction_id;
                _from = transactions[i]._from;
                _to = transactions[i]._to;
                petId = transactions[i].pet_id;
                petValue = transactions[i].pet_value;
            
        }
    }
    
    function applyToCorrect(uint transactionId,string _messageInfo) public{
        
        address _from = transactions[transactionId]._from;
        address _to = transactions[transactionId]._to;
        uint petId = transactions[transactionId].pet_id;
        uint petValue = transactions[transactionId].pet_value;
        uint id = traMessages.push(traMessage(0,transactionId,_from,_to,petId,petValue,_messageInfo,false,false))-1;
        traMessages[id]._id = id;
        emit correctEvent(transactionId,_messageInfo);
        
    }
    
    function trailCorrect(uint _id) public{
        require(msg.sender == administrator && traMessages[_id].messageState == false);
        address _From = traMessages[_id]._from;
        address _To = traMessages[_id]._to;
        uint petId = traMessages[_id].pet_id;
        uint petValue = traMessages[_id].pet_value;
        traMessages[_id].trial = true;
        _transfer(_To,_From,petId,petValue);
        traMessages[_id].messageState = true;
        emit trialEvent(_id);
        
    }
    
    function checkTraMessage(uint i) public view returns(uint traMessageId, uint transactionId, address From , address To, uint petId, uint petValue, string _messageInfo,bool _messageState,bool _trial ){
        
            traMessageId = traMessages[i]._id;
            transactionId =  traMessages[i].transaction_id;
            From =  traMessages[i]._from;
            To =  traMessages[i]._to;
            petId =  traMessages[i].pet_id;
            petValue =  traMessages[i].pet_value;
            _messageInfo =  traMessages[i].messageInfo;
            _messageState =  traMessages[i].messageState;
            _trial =  traMessages[i].trial;
      }    
}
