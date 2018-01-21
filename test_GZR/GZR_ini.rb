require "Ethereum.rb"
require "eth"
require_relative "../ruby/utils.rb"
require_relative "../ruby/Sot4.rb"

##

@contract_address = "0x3AA2a4d0F6dB1EE7f0Be0B238C43Ae7e07E09624"

##

@token = 'GZR'
@name = 'GizerToken'

@wallet_account     = '0x000c14a7cAD4d8d41cd1c375083557e05c79f476'
@redemption_account = '0x0028C11baffA46f332Ded3e7EaCe745F41b53852'
@whitelist_account  = '0xDF8f647384Ed63AA931B3C509cC07c658bD45d00'

@whitelist_key = Eth::Key.new priv: '27006809b24c2d2bc27e2b3fb929830843ac5ead81b3d8d15d83d60934b46025'

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
#@contract = Ethereum::Contract.create(client: @client, name: @name, address: @contract_address, abi: @contract_abi)
@owner_key = Eth::Key.new priv: 'b0f1974b7ac16b84be3e1489775ccd76779c9a063121dc5cf6c742cc51fbbf93'

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
