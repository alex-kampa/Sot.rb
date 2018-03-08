require_relative "GZR_ini"

File.basename(__FILE__) =~ /(\d+)\.rb$/
@sot.test_nr = $1

E6 = 1_000_000

###############################################################################

@sl.h1 'Simple demo'

epoch = @sot.var :date_presale_start
jump_to(epoch, 'presale')

###

@sot.txt "Whitelist account and receive contribution"

@sot.own :add_to_whitelist, @a[1]
@sot.snd @k[1], 1

@sot.exp :whitelist, @a[1], true
@sot.exp :balance_of, @a[1], 1000 * E6              # E6 = 1_000_000

@sot.do


###############################################################################

@sot.dump
output_pp @sot.get_state(true), "state_#{@sot.test_nr}.txt"

