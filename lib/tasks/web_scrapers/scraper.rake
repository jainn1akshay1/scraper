require 'nokogiri'

namespace :image_scraper do
	desc "scrape images form web url"

	task :scrape_url, [:url] => [:environment] do |t, args|
    images = Array.new
    url = args[:url]
    html = Nokogiri.HTML(open(url))
	srcs  = html.search('img')
	srcs.each do |src|
		images << src['src']
	end
	file_name = "#{url.split("/").last(2).join("-")}_#{Date.today.to_s}.txt"
	filepath = "#{Rails.root}/log/#{file_name}" 
	f = File.open(filepath, "w+")
	f.write(images)
	f.close
   	end
end

