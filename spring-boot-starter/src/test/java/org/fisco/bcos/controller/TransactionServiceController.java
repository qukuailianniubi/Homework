package org.fisco.bcos.controller;

import lombok.extern.slf4j.Slf4j;
import org.fisco.bcos.constants.GasConstants;
import org.fisco.bcos.temp.Transaction;
import org.fisco.bcos.web3j.crypto.Credentials;
import org.fisco.bcos.web3j.protocol.Web3j;
import org.fisco.bcos.web3j.protocol.core.methods.response.TransactionReceipt;
import org.fisco.bcos.web3j.tx.gas.StaticGasProvider;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.boot.actuate.endpoint.web.annotation.RestControllerEndpoint;



import java.math.BigInteger;
@Slf4j
public class TransactionServiceController {
    Web3j web3j;
    Credentials credentials;

    public TransactionServiceController(Web3j web3j, Credentials credentials) {
        this.web3j = web3j;
        this.credentials = credentials;
    }

    public Transaction deploy() {
        log.info("web3j : {}", web3j);
        Transaction lag = null;
        try {
            lag = Transaction.deploy(web3j, credentials,
                    new StaticGasProvider(GasConstants.GAS_PRICE, GasConstants.GAS_LIMIT)).send();
            log.info("Transaction address is {}", lag.getContractAddress());
            return lag;
        } catch (Exception e) {
            log.error("deploy lacg contract fail: {}", e.getMessage());
        }
        return lag;
    }

    public Transaction load(String creditAddress) {
        Transaction lag = Transaction.load(creditAddress, web3j, credentials,
                new StaticGasProvider(GasConstants.GAS_PRICE, GasConstants.GAS_LIMIT));
        return lag;
    }


    public boolean addUsers(String creditAddress, String name) {
        try {
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.addUsers(name).send();
            log.info("status:{}", receipt.getStatus());
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    public boolean applyCanShop(String creditAddress,String messageInfo){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.applyCanShop(messageInfo).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean setCanShop(String creditAddress,BigInteger id){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.setCanShop(id).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    /*
    public Object[] getMyInfo(String creditAddress,String from){
        Transaction lag = load(creditAddress);
        String a = users[from].name.send();
        BigInteger b = lag.balanceOf(from).send();
        boolean c = users[from].canshop.send();
        Object[] objs = new Object[]{a,b,c};
        return objs;
    }*/

    public boolean createNewPet(String creditAddress,String pet_name, String species, String date, String discribe, String url){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.createNewPet(pet_name,species,date,discribe,url).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean setPetPrice(String creditAddress, BigInteger pet_id, BigInteger pet_price){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.setPetPrice(pet_id, pet_price).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }


    public boolean setPetName(String creditAddress, BigInteger pet_id, String p_name){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.setPetName(pet_id, p_name).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean setPetState(String creditAddress, BigInteger pet_id){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.setPetState(pet_id).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean display(String creditAddress){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.display().send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean myPetDisplay(String creditAddress){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.myPetDisplay().send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean transfer(String creditAddress,String _to,BigInteger pet_id, BigInteger pet_value){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.transfer(_to,pet_id,pet_value).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }
/*
    public Object[] getTransfer(String creditAddress, int i){
        Transaction lag = load(creditAddress);
        int transactionId = lag.transactions[i].transaction_id.send();
        String _from = lag.transactions[i]._from.send();
        String _to = lag.transactions[i]._to.send();
        int petId = lag.transactions[i].pet_id.send();
        int petValue = lag.transactions[i].pet_value.send();
        Object[] objs = new Object[]{transactionId,_from,_to,petId,petValue};
        return objs;
    }*/

    public boolean applyToCorrect(String creditAddress, BigInteger transactionId,String _messageInfo){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.applyToCorrect(transactionId,_messageInfo).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }

    public boolean trailCorrect(String creditAddress, BigInteger _id){
        try{
            Transaction lag = load(creditAddress);
            TransactionReceipt receipt = lag.trailCorrect(_id).send();
            log.info("status:{}", receipt.getStatus());
        }catch(Exception e){
            e.printStackTrace();
        }
        return true;
    }


/*
    public Object[] getTraMessage(String creditAddress, int i){
        Transaction lag = load(creditAddress);
        BigInteger traMessageId = lag.traMessages[i]._id.send();
        BigInteger transactionId =  lag.traMessages[i].transaction_id.send();
        String  From =  lag.traMessages[i]._from.send();
        String To =  lag.traMessages[i]._to.send();
        BigInteger petId =  lag.traMessages[i].pet_id.send();
        BigInteger petValue =  lag.traMessages[i].pet_value.send();
        String _messageInfo =  lag.traMessages[i].messageInfo.send();
        Boolean _messageState =  lag.traMessages[i].messageState.send();
        Boolean _trial = lag.traMessages[i].trial;
        Object[] objs = new Object[]{traMessageId,transactionId,From,To,petId,petValue,_messageInfo,_messageState,_trial};
        return objs;
    }*/

}


