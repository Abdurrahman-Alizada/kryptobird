const { assert }  = require('chai');

const KryptoBird = artifacts.require('./KryptoBird');

require('chai').use(require('chai-as-promised')).should();

contract( 'KryptoBird',  (accounts)=>{
    
    let contract   
    before( async ()=>{
      contract =  await KryptoBird.deployed()
    } )

  describe('deployment', async ()=>{
      it( 'deploy successful', async ()=>{
          const address = contract.address
          assert.notEqual(address, '')
          assert.notEqual(address, null)
          assert.notEqual(address, undefined)
          assert.notEqual(address, 0x0)
      } )
      it('has a name', async ()=>{
          const name = await contract.name();
          assert.equal(name, "KryptoBird")
        })
      it('has a symbol', async ()=>{
          const symbol = await contract.symbol()
          assert.equal(symbol, "KBIRDS")
      })
  })

  describe('minting', async ()=>{
      it('create a new token', async ()=>{
        const result = await contract.mint('https...1');
        const totalSupply = await contract.totalSupply();
        // success
        assert.equal(totalSupply, 1)
        const event = result.logs[0].args;
        assert.equal(event._from, '0x0000000000000000000000000000000000000000')
        assert.equal(event._to, accounts[0], 'is msg.sender')
        // failure
        await contract.mint('https...1').should.be.rejected;  
      })
  })

//   describe('indexing', async ()=>{
//       it('list Kryptobirds', async()=>{
//         await contract.mint('https...2')
//         await contract.mint('https...3')
//         await contract.mint('https...4')
//         const totalSupply = await contract.totalSupply()
//         let result = []
//         let KryptoBird
//         for (let i = 0; i < totalSupply; i++) {
//           KryptoBird = await contract.kryptobirds(i-1)
//           result.push(KryptoBird)            
//         }
//         let expected = ['https...1','https...2','https...3','https...4']
//         assert.equal(result.join(','), expected.join(','))
//       })
//   })

} )