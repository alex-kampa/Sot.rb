require "Ethereum.rb"
require "eth"
require_relative "../lib/Sot.rb"

##

@contract_address = "0x0837639bebA93cEC81CCffa2dE17755894E5B332"

##

@token = 'GZR'
@name = 'GizerToken'

@wallet_account     = '0xF895b6041f3953B529910bA5EC50eC9a3320DC5a'
@redemption_account = '0x95f928D6DbF46B9aCa73782485fe912e1a9A3bC6'
@whitelist_account  = '0xec37F4A42e1d411266A959E29222d8221384bf38'

@whitelist_key = Eth::Key.new priv: '2afb87d5173d748d1db502a6c24774903e6a3c701d4dae3b211e2e915159dea3'

# ini variables

@E6, @E18, @DAY  = 10**6, 10**18, 24 * 60 * 60

# ini simple log

@sl = SimpleLog.new({:verbose => true})
@sl.p Time.now.utc

# test accounts

@acts = JSON.parse(File.read("acc/#{@token}.full.json"))

# variables and mappings

@vars = %w[
at_now
wallet
redemption_wallet
whitelist_wallet
date_ico_start
date_ico_end
ether_received_private
ether_received_crowd
tokens_issued_total
tokens_issued_crowd
tokens_issued_team
tokens_issued_reserve
tokens_issued_private
lockup_end_date
ico_finished
tradeable
presale_contributor_count
ico_contributor_count
]

@maps = %w[
get_balance
whitelist
balance_of
balances_crowd
balances_private
balances_locked
balance_eth_crowd
balance_eth_private
locked_balance
]

@types = {
  'eth'                 => :ether,
  'get_balance'         => :ether,
  'at_now'              => :date,
  'balance_eth'         => :ether,
  'balance_eth_private' => :ether,
  'balance_eth_crowd'   => :ether,
  'balance_of'          => :token,
  'balances_private'    => :token,
  'balances_crowd'      => :token,
  'balances_locked'     => :token,
  'tradeable'           => :bool,
  'ico_finished'        => :bool,
  'locked_balance'      => :token,
}

# ini contract and owner key

@client = Ethereum::HttpClient.new('http://127.0.0.1:8545')
@contract_abi = File.read('abi/abi.txt')
@owner_key = Eth::Key.new priv: 'ab11dde3778d0a06fb322e0c8d63185c7fcaa3f76b0489d01a4f75829c7e919a'

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
)
sot = @sot

@a  = @sot.a
@h  = @sot.h
@lk = @sot.lk
@k  = @sot.k

# sot.get_state
#
# sot.call [ 'e:get_balance', @a[300] ]
# sot.call [ 'balance_of', @a[300] ]
#
#output_pp(@sot.get_state(true), 'state.txt')


###############################################################################

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

def jump_to(epoch, label)
  @sot.txt label
  @sot.own :set_test_time, epoch + 1
  @sot.exp :at_now, epoch + 1
  @sot.do
end
