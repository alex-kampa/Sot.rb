require_relative "keys_ini.rb"

# from input: symbol and desired number of accounts to be funded

symbol = ARGV[0]
imax   = ARGV[1].to_i

abort 'usage: ruby keys_create.rb SYMBOL imax' if (symbol == '' || imax == 0)

# filenames + check

keys_file = @dir + "#{symbol}.keys.json"
acts_file = @dir + "#{symbol}.acts.txt"
hexx_file = @dir + "#{symbol}.hexx.txt"
full_file = @dir + "#{symbol}.full.json"

abort "File #{keys_file} already exists, doing nothing" if File.file?(keys_file)

# Initial balance

show_funding_balance()

# Create and fund accounts

keys = []
acts = ''
hexx = ''
full = []

(1..imax).each do |i|

  puts i
  key = Eth::Key.new

  keys[i] = Eth::Key.encrypt(key, 'znort')
  acts += "#{i}\t#{key.address}\n"
  hexx += "#{i}\t#{key.private_hex}\n"
  
  full[i] = {
    :key => Eth::Key.encrypt(key, 'znort'),
    :adr => key.address,
    :hex => key.private_hex
  }

  @client.transfer(@funding_key, key.address, 10**6 * 10**18)
  
end

# Ending balance

show_funding_balance_diff()

# Output to files

File.open(keys_file, 'w') { |f| f.write keys.to_json }
File.open(full_file, 'w') { |f| f.write full.to_json }
File.open(acts_file, 'w') { |f| f.write acts }
File.open(hexx_file, 'w') { |f| f.write hexx }

# Exit message

puts
puts "Done creating and funding #{imax} accounts for symbol #{symbol}. Files created:"
puts
puts '  ' + keys_file
puts '  ' + acts_file
puts '  ' + hexx_file
puts '  ' + full_file
puts

