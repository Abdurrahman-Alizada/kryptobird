import React, { Component, useEffect, useState } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import KryptoBird from "../abis/KryptoBird.json";
import {
  MDBCard,
  MDBCardBody,
  MDBCardTitle,
  MDBCardText,
  MDBCardImage,
  MDBBtn,
} from "mdb-react-ui-kit";
import "./App.css";

const App = () => {
  const [state, setState] = useState({
    account: "",
    contract: null,
    totalSupply: 0,
    kryptoBirdz: [],
  });
  const [account, setAccount] = useState("");
  const [contract, setContract] = useState(null);
  const [totalSupply, setTotalSupply] = useState(0);
  const [kryptoBirdz, setKryptoBirdz] = useState([]);
  const [inputValue, setInputValue] = useState("");
  useEffect(() => {
    loadWeb3();
    loadBlockchainData();
  }, []);

  const loadWeb3 = async () => {
    const provider = await detectEthereumProvider();
    if (provider) {
      console.log("ethereum wallet is connected");
      window.web3 = new Web3(provider);
    } else {
      console.log("no ethereum wallet detected");
    }
  };

  const loadBlockchainData = async () => {
    const web3 = window.web3;
    const account = await window.ethereum.request({
      method: "eth_requestAccounts",
    });
    const accounts = await window.web3.eth.getAccounts();
    setAccount(accounts[0]);

    const networkId = await window.web3.eth.net.getId();
    const networkData = KryptoBird.networks[networkId];
    if (networkData) {
      const abi = KryptoBird.abi;
      const address = networkData.address;
      const contract = new window.web3.eth.Contract(abi, address);
      setContract(contract);
      const totalSupply = await contract.methods.totalSupply().call();
      setTotalSupply(totalSupply);
      for (let i = 1; i <= totalSupply; i++) {
        const KryptoBird = await contract.methods.kryptobirds(i - 1).call();
        setKryptoBirdz([...kryptoBirdz, KryptoBird]);
      }
    } else {
      window.alert("Smart contract not deployed");
    }
  };

  // with minting we are sending information and we need to specify the account

  const mint = (kryptoBird) => {
    contract.methods
      .mint(kryptoBird)
      .send({ from: account })
      .once("receipt", (receipt) => {
        setKryptoBirdz([...kryptoBirdz, KryptoBird]);
      });
  };
  return (
    <div className="container-filled">
      {console.log(kryptoBirdz)}
      <nav
        className="navbar navbar-dark fixed-top 
                bg-dark flex-md-nowrap p-0 shadow"
      >
        <div
          className="navbar-brand col-sm-3 col-md-3 
                mr-0"
          style={{ color: "white" }}
        >
          Krypto Birdz NFTs (Non Fungible Tokens)
        </div>
        <ul className="navbar-nav px-3">
          <li
            className="nav-item text-nowrap
                d-none d-sm-none d-sm-block
                "
          >
            <small className="text-white">{account}</small>
          </li>
        </ul>
      </nav>

      <div className="container-fluid mt-1">
        <div className="row">
          <main role="main" className="col-lg-12 d-flex text-center">
            <div className="content mr-auto ml-auto" style={{ opacity: "0.8" }}>
              <h1 style={{ color: "black" }}>KryptoBirdz - NFT Marketplace</h1>
              <form
                onSubmit={(event) => {
                  event.preventDefault();
                  mint(inputValue);
                }}
              >
                <input
                  type="text"
                  placeholder="Add a file location"
                  className="form-control mb-1"
                  onChange={(e) => setInputValue(e.target.value)}
                />
                <input
                  style={{ margin: "6px" }}
                  type="submit"
                  className="btn btn-primary btn-black"
                  value="MINT"
                />
              </form>
            </div>
          </main>
        </div>
        <hr></hr>
        <div className="row textCenter">
          {kryptoBirdz.map((kryptoBird, key) => {
            return (
              <div key={key}>
                <div>
                  <MDBCard className="token img" style={{ maxWidth: "22rem" }}>
                    <MDBCardImage
                      src={kryptoBird}
                      position="top"
                      height="250rem"
                      style={{ marginRight: "4px" }}
                    />
                    <MDBCardBody>
                      <MDBCardTitle> KryptoBirdz </MDBCardTitle>
                      <MDBCardText>
                        {" "}
                        The KryptoBirdz are 20 uniquely generated KBirdz from
                        the cyberpunk cloud galaxy Mystopia! There is only one
                        of each bird and each bird can be owned by a single
                        person on the Ethereum blockchain.{" "}
                      </MDBCardText>
                      <MDBBtn href={kryptoBird}>Download</MDBBtn>
                    </MDBCardBody>
                  </MDBCard>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
};

export default App;

// import React, {useEffect} from 'react'
// import './App.css'
// import Web3 from 'web3'
// import detectEthereumProvider from '@metamask/detect-provider'
// import KryptoBird from '../abis/KryptoBird.json'

// const App = () => {

//     useEffect(()=>{
//         loadBlockChainData()
//         loadWeb3()
//     },[])

//     const loadWeb3 = async ()=>{
//         const provider = await detectEthereumProvider()

//         if(provider){
//             window.web3 = new Web3(provider)
//             console.log("wallet is connected")
//         }else{
//             console.log('not connected')
//         }
//     }
//     const loadBlockChainData = async ()=>{
//         const account = await window.ethereum.request({ method: 'eth_requestAccounts' });
//         let accounts = await window.web3.eth.getAccounts()
//         console.log(account, "=>", accounts);
//     }

//     return (
//     <div>App</div>
//   )
// }

// export default App
