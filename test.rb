
require "httparty"
require "nokogiri"
require "pry"
module WeScraping 
	class Scraping
	def initialize
		@base_url= 'http://colleges.usnews.rankingsandreviews.com/best-colleges/rankings/national-universities/data/page+'
	end
	def genrate_table
		page_number=1
		json_array =[]
		loop do
			url = @base_url + page_number.to_s
			page = HTTParty.get(url)
		    parsed_page = Nokogiri::HTML(page)
		    total_pages ||= parsed_page.css(".pager_link").css(".pager_link")[2].text.to_i
		    puts total_pages
		    puts page_number
		    # json_array << extracted_data(parsed_page)
		    break if (page_number +=1) > page_number
		end 
		puts json_array.to_json
		write_into_file(json_array)
	end
private
		def extracted_data(parse_page)
			row_array = []
			table_row = parse_page.css('.ranking-data>tbody>tr')
			table_row.each do |row|
			 row_array << extract_cells(row)
			end
			row_array
		end
		def extract_cells(row)
			 cells = row.css('td')
			 hash = Hash.new
			 hash[:name] = cells[1].text.delete("\n").strip
 			 hash[:tuition_fees] = cells[2].text.delete("\n").strip
 			 hash[:total_enrollment] = cells[3].text.delete("\n").strip
 			 hash[:acceptance_rate] = cells[4].text.delete("\n").strip
 			 hash[:average_retention_rates] = cells[5].text.delete("\n").strip
 			 hash[:graduation_rate] = cells[6].text.delete("\n").strip
 			 hash
		end
		def write_into_file(json_array)
			File.open("temp.json","w") do |f|
				f.write(json_array.to_json)
			end
		end
	end
end