pragma solidity >=0.4.22 <0.6.0;

contract Account{
    struct User{
        string name;
        bool canshop;
    }
    
    struct Message{
        address _from;
        uint _id;
        string messageInfo;
        bool messageState;
        bool trial;
    }
    
    struct Pet{
        uint pet_id;
        string pet_name;
        string species;
        string date;
        uint price;
        string discribe;
        string url;
        bool pet_state;
    }
    
    struct Transaction{
        uint transaction_id;
        address _from;
        address _to;
        uint pet_id;
        uint pet_value;
    }
    
    
    address administrator = 0x6c99f513175769fe9288470f292c928230f0ca71;

    mapping(address => User) users;
    Message[] public messages;
    Pet[] public pets;
    
    //发送信息
    event applyMessage(string _messageInfo);
    
    //答复信息
    event respondMessage(uint message_id);

    //创建新宠物
    event newPet(string pet_name, string species, string date, string discribe,string url);

   
    //公钥映射金币
    mapping(address =>uint)  balanceOf;
    //宠物ID映射公钥
    mapping (uint => address) public petToOwner; 
    //公钥映射宠物数量
    mapping (address => uint) ownerPetCount;
    

    //考虑一下是否这样设计,创建账号
    function addUsers(string name)public{
        users[msg.sender] = User(name,false);
    }
    
    //发出申请权限
    function applyCanShop(string _messageInfo) public {
        uint id = messages.push(Message(msg.sender,0,_messageInfo,false,false))-1;
        messages[id]._id = id;
        emit applyMessage(_messageInfo);
    }
    
    //管理员设置购买权限
    function setCanShop(uint _id) public{
        require(msg.sender ==administrator && messages[_id].messageState ==false);//管理员公钥
        users[messages[_id]._from].canshop = true;
        
        if(balanceOf[messages[_id]._from]==0)
            balanceOf[messages[_id]._from] = 1000;
            
        messages[_id].messageState ==true;
        
        emit respondMessage(_id);
    }
    //查看个人信息
    function checkInfo() public view returns (string, uint, bool ) {
        string storage _nickname = users[msg.sender].name;
        uint  _balance = balanceOf[msg.sender];
        bool  _canshop = users[msg.sender].canshop;
        return (_nickname, _balance, _canshop);
    }
    
    //创建新宠物
    function createNewPet(string pet_name,string species,string date, string discribe,string url) public{
        uint petId = pets.push(Pet(0,pet_name,species,date,0,discribe,url,false))-1;
        pets[petId].pet_id = petId;
        petToOwner[petId]=msg.sender;
        ownerPetCount[msg.sender]++;
        emit newPet(pet_name,species,date,discribe, url);
    }
    
    //设置宠物的相关信息
    function setPetPrice(uint pet_id,uint p_price) public{
        require(petToOwner[pet_id]==msg.sender);
        pets[pet_id].price = p_price;
    }

    function setPetName(uint pet_id,string p_name) public{
        require(petToOwner[pet_id]==msg.sender);
        pets[pet_id].pet_name = p_name;
    }
    
    function setPetState(uint pet_id) public{
        require(petToOwner[pet_id]==msg.sender);
        pets[pet_id].pet_state=!pets[pet_id].pet_state;
    }
    
}
