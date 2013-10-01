require 'nokogiri'
require 'restclient'
require 'date'

def get_vol_data(tckr)
tckr=tckr.gsub(/\n/,"")
alllines=""
url = 'http://finance.yahoo.com/q/os?s='
url2 = "&m=2013-11"

begin
page = Nokogiri::HTML(RestClient.get(url+tckr+url2))

ytckr = tckr.downcase
underlying = page.xpath('//*[@id="yfs_l84_'+ ytckr +'"]').text
num_options = page.xpath('//*[@id="content"]/table/tr[4]/td[1]/table[5]/tr[1]/td[1]/table/tr[1]/td[1]/table').children.count

	for i in 2..num_options
		thisline = tckr + "|" + underlying
		for j in 1..15
			val = "|" + page.xpath('//*[@id="content"]/table/tr[4]/td[1]/table[5]/tr[1]/td[1]/table/tr[1]/td[1]/table/tr[' + i.to_s + ']/td[' +j.to_s+ ']').text
			thisline << val
		end
		alllines << thisline << "\n"
	end
rescue
end
return alllines
end

def run_all(infile, outfile)
    begin
        File.open(infile, "r").each_line do |line|
          File.open(outfile, 'a') {|f| f.puts get_vol_data(line)}
        end 
    rescue
    end 
end
