require 'rubygems'
require 'mechanize'

a = Mechanize.new

a.get('http://www.leespalace.com/lees-calendar/') do |page|

prevLink = "null" #this is a variable to make sure duplicate links are not printed
page.links_with(:href => /event/, :dom_class => "url").each do |band| #this finds all the event links on the calendar page

infoPage = band.click # click on each link one by one

if prevLink != band.uri # only executes if previous link was not the same as the current one
   puts "" #prints an empty line to divide up the events

   #this if-end block focus on the band names, and when there are more than 1 bands playing
    if infoPage.search(".headliners").length > 1
        puts "Band(s): "
        infoPage.search(".headliners").each do |name| # if more than one bands are playing, each is outputed one by one
          puts "-" + name.text.to_s
        end
    else
        puts "Band: " + infoPage.search(".headliners").text
    end

    puts "Supports: " + infoPage.search(".supports").text
    puts "City: " + infoPage.search(".city-state").text
    puts "Date: " + infoPage.search(".dates").text
    puts "Price: " + infoPage.search(".price-range").text
    puts infoPage.search(".doors").text
    puts "Age: " + infoPage.search(".age-restriction").text
    puts "URL: http://www.leespalace.com" + band.uri.to_s
  puts ""
end

prevLink = band.uri

end

end
