require_relative "keys_ini.rb"

# inputs

symbol = ARGV[0]
i      = ARGV[1].to_i

abort 'usage: ruby keys_get_hex.rb SYMBOL i' if (symbol == '' || i == 0)

# read file and check if the requested index 

json_file = @dir + "#{symbol}.keys.json"
a = JSON.parse(File.read(json_file))
abort "error: #{i} > #{a.length - 1} (number of accounts)" if i > a.length - 1

# output account details

key = Eth::Key.decrypt a[i], 'znort'
puts key.address
puts key.private_hex