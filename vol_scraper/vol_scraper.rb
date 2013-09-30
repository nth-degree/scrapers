require 'nokogiri'
require 'restclient'
require 'date'

def get_vol_data(tckr, dt)
url = 'http://finance.yahoo.com/q/os?s=yndx&m=2013-08-17/'
#url = 'http://finance.yahoo.com/q/os?s='+tckr+'&m='+dt
page = Nokogiri::HTML(RestClient.get(url+dt))
lst = page.css("table").css("a")

i = -1
output = []
lst.each { |x|
	if x!=nil then 
			if x["href"]!=nil
			if x["href"].match('(http://www.nasdaq.com/earnings/report/)(.+)') then
			   puts i=i+1
			   output << x["href"].gsub(prefix, "") + "|" + dt2.to_s + "|" + x.children.to_s + "\n"
			end
		end
	end
}
return output
end

def run_all(outfile, dt)
    begin
    File.open(outfile, 'a') {|f| f.puts get_daily_earnings(dt)}
    rescue
  	end
end