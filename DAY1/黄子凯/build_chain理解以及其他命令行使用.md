### 周一

阅读技术文档，读build_chain执行的工作

build_chain.sh 脚本帮助用户快速搭建FISCO-BCOS联盟链

build_chain.sh 脚本用于快速生成一条链中节点的配置文件，脚本依赖于openssl（开放式安全套接层协议）



###### 功能

-l <IP list>  指定节点IP和数目

用于指定要生成的链的IP列表以及每个IP下的节点数，以逗号分隔。脚本根据输入的参数生成对应的节点配置文件，其中每个节点的端口号默认从30300开始递增，所有节点属于同一个机构和群组

-f <IP list file>通过选择使用一个指定格式的配置文件，支持创建各种复杂业务场景FISCO-BCOS链

- - 用于根据配置文件生成节点，相比于`l`选项支持更多的定制。
  - 按行分割，每一行表示一个服务器，格式为`IP:NUM AgencyName GroupList`，每行内的项使用空格分割，**不可有空行**。
  - `IP:NUM`表示机器的IP地址以及该机器上的节点数。`AgencyName`表示机构名，用于指定使用的机构证书。`GroupList`表示该行生成的节点所属的组，以`,`分割。例如`192.168.0.1:2 agency1 1,2`表示`ip`为`192.168.0.1`的机器上有两个节点，这两个节点属于机构`agency1`，属于group1和group2。

**注：**-l 和 -f 必须指定一个且不可共存



-T <Enable debug log>  

开启log级别到DEBUG



-i <Host ip>  

设置RPC和channel监听0.0.0.0， p2p模块默认监听0.0.0.0



-e <FISCO_BCOS binary path>  

用于指定fisco-bcos二进制所在的完整路径，脚本会将fisco-bcos拷贝以IP为名的目录下，不指定时，默认从GitHub下载`master`分支最新的二进制程序。



-o <Output Dir>

指定生成的配置所在的目录



-p <Start Port>

指定节点的起始端口，每个节点占用三个端口，分别是p2p,channel,jsonrpc，使用"，"`,分割端口，必须指定三个端口。同一个IP下的不同节点所使用端口从起始端口递增。



-v <FISCO-BCOS binary version>

用于指定搭建FISCO BCOS时使用的二进制版本。build_chain默认下载[Release页面](https://github.com/FISCO-BCOS/FISCO-BCOS/releases)最新版本，设置该选项时下载参数指定`version`版本并设置`config.ini`配置文件中的`[compatibility].supported_version=${version}`。如果同时使用`-e`选项指定二进制，那么通过`./fisco-bcos --version`获取指定二进制版本，并将`[compatibility].supported_version`设置为获取的二进制版本。



-d <docker mode>

使用docker模式搭建FISCO BCOS，使用该选项时不再拉取二进制，但要求用户启动节点机器安装docker且账户有docker权限。



-s <State type>

无参数选项，设置该选项时，节点使用[mptstate](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/design/storage/mpt.html)存储合约局部变量，默认使用[storagestate](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/design/storage/storage.html)存储合约局部变量。



-S <Storage type>

无参数选项，设置该选项时，节点使用外部数据库存储数据，目前支持MySQL



-c <Consensus Algorithm>

 无参数选项，设置该选项时，设置节点的共识算法为[Raft](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/design/consensus/raft.html)，默认设置为[PBFT](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/design/consensus/pbft.html)。



-C <Chain id>

用于指定搭建FISCO BCOS时的链标识。设置该选项时将使用参数设置`config.ini`配置文件中的`[chain].id`，参数范围为正整数，默认设置为1



-g <Generate guomi nodes>

无参数选项，设置该选项时，搭建国密版本的FISCO BCOS。**使用g选项时要求二进制fisoc-bcos为国密版本**



-z <Generate tar packet>

无参数选项，设置该选项时，生成节点的tar包



-t <Cert config file>

该选项用于指定生成证书时的证书配置文件



-T<Enable debug log>

无参数选项，设置该选项时，设置节点的log级别为DEBUG。log相关配置[参考这里](https://fisco-bcos-documentation.readthedocs.io/zh_CN/latest/docs/manual/log_access.html)。



-F <Disable log auto flush>





### 周二

尝试其他控制台命令行

switch  切换到指定群组

（由于目录下的applicationContext.xml文件下无群组2的信息，故切换失败）

![1559701068789](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/switch.png)

getSealerList    查看共识节点列表（运行了4个共识节点）

![1559701310223](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getSealerList.png)

getObserverList  查看观察节点列表（无设置故返回空）

![1559701431701](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getObserverList.png)

getNodeIDList     查看节点及连接p2p节点的nodeId列表（与共识节点列表相同）

![1559701507053](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getNodeIDList.png)

getPbftView   查看pbft视图（跟PBFT算法有关，具体不清楚）

![1559701622837](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getPbftView.png)

getConsensusStatus  查看共识状态

![1559701922691](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getConsensusStatus.png)

getSyncStatus  查看同步状态（从中观察到4个共识节点的genesisHash和latestHash一致）

![1559702149505](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getSyncStatus.png)

getNodeVersion  查看节点的版本

![1559702265178](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getNodeVersion.png)

getPeers 查看节点的peers  （可以获取节点的相关信息（协议，端口，名称，ID，Topic）

![1559702333098](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getPeers.png))

getGroupPeers  查看节点所在group的所有共识节点和观察节点列表（getSealerList和getObserverList 的结合）

![1559702810787](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getGroupPeers.png)

getGroupList  查看群组列表

![1559702927316](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getGroupList.png)

getBlockByHash  根据区块哈希查询区块信息

![1559703327354](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getBlockByHash.png)



getBlockHashByNumber  通过区块高度获取区块哈希

![1559703493325](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getBlockHashByNumber.png)

getTransactionByHash 通过交易哈希查询交易信息

![1559703681843](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getTransactionByHash.png)

getTransactionByBlockHashAndIndex 通过区块哈希和交易索引查询交易信息

![1559703944648](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getTransactionByBlockHashAndIndex.png)

getTransactionByBlockNumberAndIndex 通过区块高度和交易索引查询交易信息

![1559704107604](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getTransactionByBlockNumberAndIndex.png)

getTransactionReceipt 通过交易哈希查询交易回执

![1559704252224](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getTransactionReceipt.png)

getPendingTxSize 查询等待处理的交易数量

![1559704631779](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getPendingTxSize.png)

getPendingTransactions  查询等待处理的交易

![1559704770448](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getPendingTransactions.png)

getCode  根据合约地址查询合约二进制代码

![1559705514714](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getCode.png)

getTotalTransactionCount

![1559705574559](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/getTotalTransactionCount.png)

queryCNS

![1559705696784](https://github.com/qukuailianniubi/Homework/raw/master/DAY1/%E9%BB%84%E5%AD%90%E5%87%AF/assert/queryCNS.png)

