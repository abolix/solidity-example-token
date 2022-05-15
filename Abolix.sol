
// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;


contract MyContract {
	string public name;
	string public symbol;
	uint8 public decimals = 8;
	uint public totalSupply;

	mapping(address => uint) public balanceOf;
	mapping (address => mapping (address => uint)) public allowed;

	// Events
    event Transfer(
        address indexed from,
        address indexed to,
        uint value
    );

    event Approval(
        address indexed owner,
        address indexed spender,
        uint value
    );

	event Burn(
		address indexed from,
	 	uint value
	);

	uint initSupply = 1000000;
	string tokenName = 'AbolixToken';
	string tokenSymbol = 'ABX';

	constructor() {
		// totalSupply = initSupply*10**uint(decimals);

		totalSupply = 50000;
		balanceOf[msg.sender] = totalSupply;
		name = tokenName;
		symbol = tokenSymbol;
	}




	 function _transfer(address from, address to, uint value) internal {
		require(to != address(0));

		balanceOf[from] = balanceOf[from] - value;
        balanceOf[to] = balanceOf[to] + value;
        emit Transfer(from, to, value);
	 }

	 function transfer(address to, uint value) public returns (bool success) {
		 _transfer(msg.sender, to, value);
		 return true;
	 }

	function transferFrom(address from, address to, uint value) public returns (bool success) {
		allowed[from][msg.sender] = allowed[from][msg.sender] - value;
		_transfer(from, to, value);
		return true;
	}

	 function approve(address spender, uint value) public returns (bool success) {
			require(spender != address(0));

		 	allowed[msg.sender][spender] = value;
			emit Approval(msg.sender, spender, value);
			return true;
	 }

	 function increaseApproval(address spender, uint value) public returns (bool success) {
			require(spender != address(0));

		 	allowed[msg.sender][spender] = allowed[msg.sender][spender] + value;
			emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
			return true;
	 }

	 function decreaseApproval(address spender, uint value) public returns (bool success) {
			require(spender != address(0));

		 	allowed[msg.sender][spender] = allowed[msg.sender][spender] - value;
			emit Approval(msg.sender, spender, allowed[msg.sender][spender]);
			return true;
	 }

	 function _mint(address account, uint value) internal {
			require(account != address(0));

			totalSupply = totalSupply + value;
			balanceOf[account] = balanceOf[account] + value;
			emit Transfer(address(0), account, value);
	 }

	function mint(address account, uint value) public returns(bool success) {
		_mint(account, value);
		return true;
	}

	function _burn(address account, uint value) internal {
			require(account != address(0));

			totalSupply = totalSupply - value;
			balanceOf[account] = balanceOf[account] - value;
			emit Burn(account, value);
	 }

	function _burnFrom(address account, uint value) internal {
		 	allowed[account][msg.sender] = allowed[account][msg.sender] - value;
			_burn(account,value);
	 }

}

