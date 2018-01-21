Sot.rb is a Ruby script to simplify testing Solidity smart contracts.

Example:

```ruby
@sot.txt 'Some minting (ok) and an early contribution (throws)'

@sot.own :mint_reserve, @a[1], 100000 * @E6 # minting by owner (@E6 = 1_000_000)
@sot.own :mint_team,    @a[1],  50000 * @E6 # more minting by owner

@sot.snd @k[1], 10 # contribution by test account 1 - rejected 

@sot.exp :balance_of, @a[1], 161500 * @E6, 150000 * @E6 # expected token balance and change for account 1

@sot.do # perform 
```

Result in the log file (note that in addition to requested verifications, all changes to tracked variables are reported): 

```
== Some minting (ok) and an early contribution (throws)
== 

ACTIONS
CONTRIBUTE : @client.transfer(acct_#<Eth::Key:0x0000000005bca1d8>, 0x64896218f5f7BFa39b2B997554F7C600D8143E4F, 10)

VERIFY
ok  val [balance_of acc1] 1 is 161500000000 as expected
ok  diff [balance_of acc1] is 150000000000 as expected

DIFFERENCES
[:c, :tokens_issued_total, 126500.0, 276500.0, 150000.0]
[:c, :tokens_issued_team, 0.0, 50000.0, 50000.0]
[:c, :tokens_issued_reserve, 0.0, 100000.0, 100000.0]
[1, :get_balance, 999999.818814094, 999999.730814094, -0.088]
[1, :balance_of, 11500.0, 161500.0, 150000.0]
[1, :balances_locked, 0.0, 50000.0, 50000.0]
[1, :locked_balance, 0.0, 50000.0, 50000.0]
```

## Requirements

Sot.rb relies on the _Ethereum.rb_ and _Eth_ gems and needs to communicate with a Parity node.

## Limitations

Sot.rb has not yet been bundled as a gem as it seems too early to do so, and the documentation remains to be completed. 

## Example

For an example of use, please look at the test_GZR directory. Using a Party development chain is recmmended for performance reasons.

```
parity --no-persistent-txqueue --chain dev
```

### @sot object initialisation

In the file GZR_ini.rb, the @sot object is initialised:

```ruby
@sot = Sot.new(
  {
  :client  => @client,            # "Ethereum.rb" object - e.g. Ethereum::HttpClient.new('http://127.0.0.1:8545')
  :name    => @name,              # String - name of the contract
  :address => @contract_address,
  :abi     => @contract_abi,      # String - full text of the contract abi
  :own_key => @owner_key,         # "eth" object - private key of the contract owner
  :sl      => @sl,                # SimpleLog object - cf utils.rb
  :acts    => @acts,              # json - content of a SYMBOL.full.json file generated using keys_create.rb
  :vars    => @vars,              # Array  - contract variables to be tracked
  :maps    => @maps,              # Array - contract maps to be tracked
  :types   => @types,             # Hash - definition of variable types (:ether, :token, :bool)
  :test_nr => @test_nr,           # Integer - (optional) test number
  :imax    => 20                  # Integer - (optional) number of test accunts to track, default = 20
  }
```
)

The variable names provided in @vars tell @sot to track changes to these variables at various testing stages. Similarly, @maps are the mappings whose changes will be tracked for all test accounts.

@types is used to specify the type of a variable when this is not obvous from the variable name, the possble values being :address :bool :date :ether and :token. This is used for output formatting. When the variable name contains the keywords 'address' 'date' 'ether' or 'token', it does not need to be declared in @types.

```
@types = {
  'eth'                 => :ether,
  'get_balance'         => :ether,
  'at_now'              => :date,
  'tradeable'           => :bool,
  'locked_balance'      => :token,
  ...
}
```

### running test cases - overview

The files GZR_test_1.rb, GZR_test_2.rb, ... represent different test scenarios. For each scenario, a new contract has to be deployed. 

In GZR_test_1.rb, the following code is used to call the function addToWhitelist by an account with private key @whitelist_key, with the argument @a[1] corresponding to the first test account:

```ruby
@sot.txt 'Add to whitelist'
@sot.add :add_to_whitelist, @whitelist_key, @a[1]
@sot.exp :whitelist, @a[1], true
@sot.do
```

The result as output to the log function is: 

```
========================================
== Add to whitelist
== 

ACTIONS

VERIFY
ok  val [whitelist acc1] 1 is true as expected

DIFFERENCES
[1, :whitelist, false, true]
```

Note that the DIFFERENCES section lists the differences between states, independently of the requested verifications. 

### running test cases - details

_to be completed_


