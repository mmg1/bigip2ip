#!/usr/bin/env ruby
#
#cla => Decimal
# printf 'GET / HTTP/1.0\nHOST:domain.com\n\n' | ncat domain.com 80  | grep -i bigip
# BIGipServerPool_cla=252029120.10499.0000
#
# saaf => Hex
# printf 'GET / HTTP/1.0\nHOST:saaf.domain.com\n\n' | ncat --ssl saaf.domain.com 443  | grep -i bigip
# BIGipServerpool_SaafFarm_4.17-24=rd4o00000000000000000000ffffc0a80411o80
#
# header = "BIGipServerPool_cla=252029120.10499.0000".split("=").last.split(".").first #=> "252029120"
# Read All BigIP Techinques in IP encoding
# http://support.f5.com/kb/en-us/solutions/public/6000/900/sol6917.html
#
# from big up to ip
# s = 1677787402.to_s 16 # "6401010a"   << Hex
# ss = s.scan(/.{2}/)   #=> ["64", "01", "01", "0a"]
# sss = ss.reverse.map {|o| o.hex}.join(".")  #=> "100.1.1.10"
#

require 'optparse'


class Integer

  def to_decimal
    number = self
    result = []
    4.times do
	result.push number & 255
	number = number >> 8
    end

    result.join('.')
  end

  def to_decimal_reverse
    number = self
    result = []
    4.times do
      result.push number & 255
      number = number >> 8
    end

    result.reverse.join('.')
  end

end


options = {}
optparse = OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]  VALUE"

  opts.on("--decimal2dot DECIMAL", "Convert decimal to doted format") do |o|
    options[:decimal2dot] = o
  end

  opts.on("--dot2decimal IP-ADDR", "Convert doted to decimal format") do |o|
    options[:dot2decimal] = o
  end

  opts.on("--hex2dotdecimal HEX", "Convert Hex to doted decimal format") do |o|
    options[:hex2dotdecimal] = o
  end

  opts.on( '-h', '--help', "Display help screen\n" ) 	do
    puts opts
    puts "\nExamples:\n" + "ruby bigip2ip.rb --decimal2dot 252029120"
  end

end

optparse.parse!
options
ARGV

case
  #-->
  when options[:decimal2dot]
    puts "#{options[:decimal2dot]}".to_i.to_decimal
  when options[:hex2dotdecimal]
    puts "#{options[:hex2dotdecimal]}".hex.to_i.to_decimal_reverse
  else
    puts optparse
end








