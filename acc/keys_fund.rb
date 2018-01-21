require_relative "keys_ini.rb"

# this is to refill accounts after a blockchain reset

symbol = ARGV[0]
abort 'Usage: ruby keys_fund.rb SYMBOL' if symbol.to_s == ''
acts_file = @dir + "#{symbol}.acts.txt"
abort "File #{acts_file} not found, doing nothing" if !File.file?(acts_file)

# read accounts

accounts = []

File.read(acts_file).split("\n").each do |x|
  x =~ /\t(0x\w*)/
  accounts << $1
end

# check if account 1 has a balance

bal = @client.get_balance(accounts[0]).to_f / 10**18
abort "\n\nFound #{comma_numbers(bal)} ether in the first account, aborting!\n\n" if bal > 0

# Fund accounts

show_funding_balance()

accounts.each do |account|
  @client.transfer(@funding_key, account, 10**6 * 10**18)
end

show_funding_balance_diff()


