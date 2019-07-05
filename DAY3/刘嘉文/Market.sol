pragma solidity >=0.4.22 <0.6.0;

import "./Account.sol";

contract Market is Account{

     function _infomation(uint _id) view returns (
         string _name,
         string _species,
         string  _date,
         uint _price,
         string _discribe,
         string _url
    ){
         Pet storage pet = pets[_id];
         
         _name = pet.pet_name;
         _species = pet.species;
         _date = pet.date;
         _price = pet.price;
         _discribe = pet.discribe;
         _url = pet.url;
         
     }

     
     //查看所有宠物
     function display() {
         for(uint i =0; i < pets.length; i++){
             if(pets[i].pet_state == true){
                 _infomation(i);
             }
         }
     }
     
     //查看自己的的宠物
     function myPetDisplay() public {
         for(uint i =0; i<pets.length;i++){
             if(petToOwner[i] == msg.sender){
                 _infomation(i);
             }
         }
     }
}
