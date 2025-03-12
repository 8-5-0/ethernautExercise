* step1: 观察代码发现proxy使用delegatecall来调用implementation, 利用这个将owner修改为自己
* step2: 把合约地址添加白名单
* step3: multicall(deposite(),multicall(deposite()))即可绕过bool检测
* strp4: 取光钱然后setMaxBalance(owner)=msg.sender
