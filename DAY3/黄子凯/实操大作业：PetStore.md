#### **实操大作业：PetStore**

 

设计一个宠物售卖和转卖分布式市场

相关角色：

\1. 出售人：将宠物上架，制定价格，售卖成功则收款。

\2. 购买人：选择宠物，进行购买，初始资金分配10000元。

\3. 宠物：ID，名称，品类（猫，狗，兔等），出生日期，价格，描述（一段文字供展示）等,，有效状态,图片所在url等扩展信息

\4. 管理员：帐户开户，初始化，监测市场里的宠物价格分布，售卖次数，处理纠纷。

\5. 市场：展示在售宠物列表

 

参考实现：

·     首先管理员在链上为一个人开户，出售人和购买人本质上都是自然人，其基本属性是名字和帐户余额，以及名下的宠物列表。 

·     人可以创建一个宠物，一个宠物被创建后，挂接到一个人的名下，在被失效之前，就一直有效，宠物被创建时并没有价格

·     宠物上架时可以制定一个价格，被置为上架状态

·     宠物上架后可写入一个市场合约，所有人都可以看到

·     购买人选择市场里的宠物，发起购买，进入交易合约，交易合约判断有效状态，如果是在售的，就允许交易，否则拒绝，如果允许交易的，则判断购买人余额是否足够，进行扣款，并将款项写入出售人帐户，将宠物转给购买人。生成一个购买订单记录。

·     如果购买人觉得货不对板或售卖人反悔，可以发起仲裁，将相关信息全部发给监督员，审计人根据订单情况，进行仲裁（模拟），如果仲裁为交易无效，则冲正上述款项和宠物归属。可通过权限体系，使得只有监督员可以操作冲正接口。

   

参考基本合约列表 

· 帐户管理合约

· 市场合约

· 交易合约

· 冲正管理合约

 