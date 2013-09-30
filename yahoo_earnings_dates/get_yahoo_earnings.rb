require 'nokogiri'
require 'restclient'
require 'date'

def get_data(tckr)
	output = ""
	begin
	url = 'http://finance.yahoo.com/q?s='
	tckr=tckr.gsub(/\n/,"")
	page = Nokogiri::HTML(RestClient.get(url+tckr))
	str_date = page.xpath('//*[@id="table1"]/tr[7]/td[1]').text
	frm_date = Date.parse(str_date, '%mmm %d,%Y').to_s
	output = tckr + "|" + frm_date
	rescue
end
	return output
end

def run_all(infile, outfile)
    begin
				File.open(infile, "r").each_line do |line|
					File.open(outfile, 'a') {|f| f.puts get_data(line)}
					end
    rescue
  	end
end
