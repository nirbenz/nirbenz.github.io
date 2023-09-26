require 'nokogiri'
require 'open-uri'
require 'date'

is_standalone = false

if !defined?(Jekyll::Site)
  is_standalone = true
  require 'jekyll'
end

def write_jekyll_post(data)
  # Patch 
  title = data['title'].gsub('2021', '2022')
  post_date = DateTime.parse(data['feed_date']).strftime('%Y-%m-%d')
  post_name = "#{post_date}-#{title.downcase.gsub(' ', '-')}.md"
  post_path = "_posts/#{post_name}"

  File.open(post_path, 'w') do |file|
    file.write("---\n")
    file.write("layout: post\n")
    file.write("title: #{title}\n")
    file.write("subtitle: #{data['first_h4']}\n")
    file.write("cover-img: #{data['feed_image']}\n")
    file.write("thumbnail-img: #{data['feed_image']}\n")
    file.write("share-img: #{data['feed_image']}\n")
    file.write("redirect-url: #{data['feed_url']}\n")
    file.write("---\n\n")
    file.write("Posted on Medium")
    # file.write("<script>window.location.href = '#{data['feed_url']}';</script>")
    # file.write("#{data['feed_content']}")
    # truncated_content = data['feed_content'][0..99]
    # file.write("<p style='font-size: large;'>#{truncated_content}...<a href='#{data['feed_url']}'>Read More</a></p>\n")

  end
end



puts "Fetching from medium account..."

module Jekyll
  class MediumPostDisplay < Generator
    safe true
    priority :high

    def initialize(is_standalone = false)
      @is_standalone = is_standalone
    end

    def generate(site)
      medium_url = "https://medium.com/feed/@" + (site.config["medium_feed"] || "nzvi")
      puts medium_url
      @post_titles = []
      jekyll_coll = Jekyll::Collection.new(site, 'medium_posts')
      site.collections['medium_posts'] = jekyll_coll
      xml = URI.open(medium_url).read
      doc = Nokogiri::XML(xml)
      entries = doc.xpath('//channel/item')

      entries.each do |e|


        title = e.xpath('title').text
        content = e.xpath('content:encoded').text
        url = e.xpath('link').text
        updated_time = e.xpath('atom:updated').text
        updated_time = DateTime.parse(updated_time)
        formatted_time = updated_time.strftime('%m-%d-%Y')

        # format text
        parsed_content = Nokogiri::HTML(content)
        first_text = parsed_content.xpath('//p')[1].text if parsed_content.xpath('//p').length > 1
        first_img_url = parsed_content.at('img')['src'] if parsed_content.at('img')
        first_h4 = parsed_content.at('h4').text if parsed_content.at('h4')

        printf "%-20s %s\n", "", title
        printf "%-20s %s\n", "", url


        @post_titles << Array([title, url, formatted_time])
        # puts Array([title, url, formatted_time])
      
        path = site.in_source_dir("_external_feed/#{title}.md")
        doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
        doc.data['title'] = title
        doc.data['feed_content'] = first_text
        doc.data['feed_date'] = formatted_time
        doc.data['feed_url'] = url
        doc.data['feed_h4'] = first_h4
        doc.data['feed_image'] = first_img_url
        jekyll_coll.docs << doc
        # site.docs << doc

        if @is_standalone
          write_jekyll_post(doc.data)
        end
      end
    end
  end
end

if is_standalone
  site = Jekyll::Site.new(Jekyll.configuration({
    "source" => ".",
    "destination" => "./_site",
    "medium_feed" => "nzvi"
  }))
  
  generator = Jekyll::MediumPostDisplay.new(is_standalone)
  generator.generate(site)
  puts "\n"
  printf "%-20s %s\n", "", "DEBUG: Fetched posts:"
  printf "%-20s %s\n", "", generator.instance_variable_get(:@post_titles).join("\n")
end