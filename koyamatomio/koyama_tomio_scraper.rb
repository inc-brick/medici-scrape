require 'nokogiri'
require 'open-uri'
require './koyamatomio/koyama_tomio_gallarey'

# result
exhibition_pages = []
@count = 0
@target_data = []

def exhibition_page_from_archive(archive_page_url)
  res = []
  archive_page = Nokogiri::HTML(open(archive_page_url))
  archive_page.css('.section-exhibitions-archives article .anchor-block').each do |row|
    @count+=1
    res << row[:href]
  end
  res
end

# to get each sub content
def parse_sub_content(content)
  sub_content_list = content.split("<br>")
  sub_content_list.map { |row| row.strip }
end

def address(content)
  parse_sub_content(content).select { |row| row.match(/[都道府県]/) }[0]
end

def reception_datetime(content)
  parse_sub_content(content).select { |row| row.match(/^[0-9]{4}/) }[0]
end

def extract_data(url)
  data = KoyamaTomioGallarey.new
  doc = Nokogiri::HTML(open(url).read, url)
  sub_content = doc.css('.exhibition-sub').inner_html

  data.gallery_name = doc.css('.exhibition-location').inner_text
  data.exhibition_name = doc.css('.entry-title').inner_text
  data.artist_name = doc.css('.artist a').inner_text
  data.term = doc.css('.exhibition-date .exhibition-open-date').inner_text + doc.css('.exhibition-date .exhibition-close-days').inner_text
  data.address = address(sub_content)
  data.reception_date = reception_datetime(sub_content)
  data.content = doc.css('.entry-content').inner_text
  data.profile = doc.css('.artist-infomation').inner_text.strip
  data.img = doc.css('.eyecatch img')[0][:src]
  @target_data << data
end

# input source
doc = Nokogiri::HTML(open('http://tomiokoyamagallery.com/exhibitions/'))

# access to current exhibition
currents = doc.css('.section-exhibitions-current')
currents.css('a').each do |item|
  src = item[:href]
  exhibition_pages << src
  @count+=1
end

# access to upcoming exhibition
upcoming = doc.css('.section-exhibitions-upcoming')
upcoming.css('a').each do |item|
  src = item[:href]
  exhibition_pages << src
  @count+=1
end

# access to archive page
archive_page_url = doc.css('.section-exhibitions-archives .more')[0][:href]
pagination_urls = [archive_page_url]

# access top archive page to get pagination info
first_archive_page = Nokogiri::HTML(open(archive_page_url))
first_archive_page.css('.wp-pagenavi .page').each do |item|
  pagination_urls << item[:href]
end

# access to each archive page
pagination_urls.each_with_index do |archivePage, idx|
  exhibition_pages << exhibition_page_from_archive(archivePage) if idx < 0
end

exhibition_pages.each { |page| extract_data(page) }

@target_data.each do |data|
  puts data.to_string
end

puts @count
