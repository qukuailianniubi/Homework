# Solidity

> Solidity 是一门面向合约的、为实现智能合约而创建的高级编程语言。这门语言受到了 C++，Python 和 Javascript 语言的影响，设计的目的是能在以太坊虚拟机（EVM）上运行。Solidity 是静态类型语言，支持继承、库和复杂的用户定义类型等特性。

### 语法

#### 数据类型

##### 布尔值 整型
```
    true && false

    # 常见uint 代表uint256
    int8 & int256
    uint8 & uint256

    # 类型推断
    var i = 123 #uint
    var s = "string" #自动转string

    #类型转换，大转小可能截断
    uint32 a = 0x12345678;
    uint16 b = uint16(a); // b will be 0x5678 now
```

##### 枚举Enum
```
    enum Direction {East, South, West, North}
    Direction constant myDirection = Direction.South;

    function getDirection()public pure returns (Direction) {
        return myDirection;
    }
```

#### 引用类型

##### 字符串string，bytes
```
    string str = "Hello";
    bytes32 bts = "World";
    function lenght() public view returns(uint){
    // length 返回长度
    return bts.length;
    }
```

##### 数组
```
    uint[] public intArray;
    function add(uint val) public {
        intArray.push(val);
    }

    function getInt(uint _index) public view returns (uint) {
        assert(intArray.length > _index);
        return intArray[_index];
    }
    // 动态数组
    function memArr() public view returns (uint) {
        uint[] memory a = new uint[](7);
        uint[3] memory b = [uint(1), 2, 3];
    }
```

##### 结构struct
```
    struct User {
      string name;
      uint age;
    }
```

#### 函数
> Enum上面就是函数写法，四种作用域
> public
> private
> internal
> external

##### 数据位置memory和storage
> memory 存在于内存，可回收，calldata类似
storage 永远存在
同位置的赋值传引用，不同位置转换会拷贝

强制的数据位置(Forced data location)

>外部函数(External function)的参数(不包括返回参数)强制为：calldata
状态变量(State variables)强制为: storage

默认数据位置（Default data location）
> 函数参数（括返回参数：memory
所有其它的局部变量：storage

##### 函数修改器 modifier
> 用于在函数执行前检查某种前置条件。
修改器是一种合约属性，可被继承，可重写

```
    contract owned {
    function owned() { owner = msg.sender; }
    address owner;

    modifier onlyOwner {
        if (msg.sender != owner)
            throw;
        _;
    }
}

contract mortal is owned {
    function close() onlyOwner {
        selfdestruct(owner);
    }
}
```

##### 回退函数
> 每一个合约有且仅有一个没有名字的函数。这个函数无参数，也无返回值。
1.调用合约时，没有匹配上任何一个函数(或者没有传哪怕一点数据)，就会调用默认的回退函数。
2.当合约收到ether时（没有任何其它数据），也会调用默认的回退函数。
避免用过多gas：
写入到存储(storage)，创建一个合约，执行一个外部(external)函数调用，发送ether
一个没有定义一个回退函数的合约。如果接收ether，会触发异常，并返还ether。
    