require 'Ethereum.rb'
require 'eth'
require 'json'

# settings

@dir = './out/'
@client = Ethereum::HttpClient.new('http://127.0.0.1:8545')
@funding_key = Eth::Key.new priv: '3b5c408c5012a396bb6229fe2b5e06aec775f96d31c659511c3193a73149c67e'

#

@funding_address = @funding_key.address
@funding_balance = @client.get_balance(@funding_address).to_f / 10**18

abort "Directory #{@dir} not found, doing nothing" if !File.directory?(@dir)

def comma_numbers(number, delimiter = ',')
  res = number.to_i.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
  res += '.' + (number - number.to_i).to_s.split('.')[1] if (number - number.to_i > 0)
  res
end

def show_funding_balance()
  @funding_balance = @client.get_balance(@funding_address).to_f / 10**18
  puts 'Funding acct balance: ' + comma_numbers(@funding_balance)
end

def show_funding_balance_diff()
  balance = @client.get_balance(@funding_address).to_f / 10**18
  diff = balance - @funding_balance
  puts "Funding acct balance: #{comma_numbers(balance)} (#{comma_numbers(diff)})"
  @funding_balance = balance
end
