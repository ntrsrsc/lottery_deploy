const assert = require("assert");
const ganache = require("ganache-cli");
const fs = require("fs");
const Web3 = require("web3");
const { isBoolean } = require("util");
const web3 = new Web3(ganache.provider());
const bytecode = fs.readFileSync('./build/__contracts_lottery_sol_Lottery.bin');
const abi = JSON.parse(fs.readFileSync('./build/__contracts_lottery_sol_Lottery.abi'));
var accounts;
var basic_data_type;

beforeEach(async () => { 
    accounts = await web3.eth.getAccounts()
    lottery = await 
    
    new web3.eth.Contract(abi)
        .deploy({ 
            data: '0x'+bytecode, 
            arguments: ['Hello World'] 
        }).send({
            from: accounts[0], 
            gas:'1000000'
    });
 
});
describe('Lottery',() => { 
    it('deploys contract', () => { 
        assert.ok(lottery.options.address); 
    });

    it('i is set by setInt',async ()=> {
        await basic_data_type.methods.setUint(0).send({ from: accounts[0] } 	);
        const i = await basic_data_type.methods.i().call(); 
            assert.strictEqual(i, '0');
    });
});