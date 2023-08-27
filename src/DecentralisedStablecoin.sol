// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;


import { ERC20Burnable, ERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import { Ownable } from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";


contract DecentralizedStablecoin is ERC20Burnable, Ownable {
    error DecentralizedStablecoin__MustBeMoreThan0();
    error DecentralizedStablecoin__BurnAmmountExceedsBalance();
    error DecentralizedStablecoin__ZeroAddress();


    constructor() ERC20("DecentralizedStablecoin", "DSC") {}

    function burn(uint256 _amount) public override onlyOwner {
        uint256 balance = balanceOf(msg.sender);
        if (_amount <= 0) {
            revert DecentralizedStablecoin__MustBeMoreThan0();
        }
        if (balance < _amount) {
            revert DecentralizedStablecoin__BurnAmmountExceedsBalance();
        }
        super.burn(_amount);
    }
    function mint(address _to, uint256 _amount) external onlyOwner returns(bool) {
        if(_to == address(0)) {
            revert DecentralizedStablecoin__ZeroAddress();
        }
        if(_amount <= 0) {
            revert DecentralizedStablecoin__MustBeMoreThan0();
        }
        _mint(_to, _amount);
        return true;
    }
}
