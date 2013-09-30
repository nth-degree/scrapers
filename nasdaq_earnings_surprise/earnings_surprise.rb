require 'nokogiri'
require 'restclient'
require 'date'

def get_surprise_history(tckr)
url = 'http://www.nasdaq.com/earnings/report/'
page = Nokogiri::HTML(RestClient.get(url+tckr))

surprises = ""
for i in 3..6
	begin
		this_line = ""
		this_line << tckr.gsub(/\n/,"") + "|"
		this_line << Date.strptime(page.xpath('//*[@class="earningsurprise"]/tr['+ i.to_s + ']/td[2]').text, '%m/%d/%Y').to_s + "|"
		this_line << page.xpath('//*[@class="earningsurprise"]/tr['+ i.to_s + ']/td[3]').text + "|"
		this_line << page.xpath('//*[@class="earningsurprise"]/tr['+ i.to_s + ']/td[4]').text + "|"
		this_line << page.xpath('//*[@class="earningsurprise"]/tr['+ i.to_s + ']/td[5]').text
		surprises << this_line + "\n"
	rescue
	end
end
return surprises
end

def run_all(infile, outfile)
    begin
				File.open(infile, "r").each_line do |line|
					File.open(outfile, 'a') {|f| f.puts get_surprise_history(line)}
				end
    rescue
  	end
end
