Utility for funding multiple test accounts and creating files containing account information, for use with Sot.rb.

## Usage

Start by editing the configuration variables in keys_ini.rb: 

```ruby
@dir = './out/'
@client = Ethereum::HttpClient.new('http://127.0.0.1:8545')
@funding_key = Eth::Key.new priv: '3b5c408c5012a396bb6229fe2b5e06aec775f96d31c659511c3193a73149c67e'
```

Make sure that the account corresponding to @funding_key has sufficient Ether, then run keys_create.rb, providing the symbol and number of accounts to be funded as inputs: 

```ruby
ruby -W0 keys_create.rb TEST 10
```

Resulting message:

```
Funding acct initial balance: 999,919,999,999.9630126953125
1
2
3
4
5
6
7
8
9
10
Funding acct ending balance: 999,909,999,999.9583740234375
Difference: -10,000,000
Done creating and funding 10 accounts for symbol TEST.

Created files:

  ./out/TEST.keys.json
  ./out/TEST.acts.txt
  ./out/TEST.hexx.txt
  ./out/TEST.full.json
```
  
## Suppressing warnings

The 'eth' module uses Bignum which is deprecated in Ruby 2.4. To suppress warnings, run with -W0, for example: 

```
ruby -W0 keys_create.rb TEST 100
```

## Refill accounts after a blockchain reset

To refill accounts after a blockchain reset, use: 

```
ruby keys_fund.rb TEST
```

## Get the private key of an acocunt

To quickly get the pivate key of an acocunt, use 

```
ruby keys_get_hex.rb TEST 5
```

This will out put the account number and priate key of the 5th account, for example:

```
0xF895b6041f3953B529910bA5EC50eC9a3320DC5a
7c300fff1d50cb611f07a3e0377a0861249f31e5a3a47a392c3360b4b9ca8590
```

Note that account numbering starts with 1.