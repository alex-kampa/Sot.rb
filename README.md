Sot.rb is a Ruby script to test Solidity smart contracts.

## Requirements

Sot.rb relies on the _Ethereum.rb_ and _Eth_ gems and needs to communicate with a Parity node.

## Limitations

Sot.rb has not yet been bundled as a gem, and the documentation still remains to be written. 

## Example

_this section remains to be completed_

For an example of use, please look at the test_GZR directory. In the file GZR_ini.rb, the @sot object is defined:

```ruby
@sot = Sot.new(
  {
  :client  => @client,
  :name    => @name,
  :address => @contract_address,
  :abi     => @contract_abi,
  :own_key => @owner_key,
  :sl      => @sl,
  :acts    => @acts,
  :vars    => @vars,
  :maps    => @maps,
  :types   => @types,
  :test_nr => @test_nr
  }
```
)

The files GZR_test_1.rb, GZR_test_2.rb, ... represent different test scenarios.

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

Note that all DIFFERENCES between states are listed. 