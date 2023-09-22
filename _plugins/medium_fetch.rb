require 'feedjira'

is_standalone = false

if !defined?(Jekyll::Site)
  is_standalone = true
  require 'jekyll'
end

puts "Fetching from medium account..."

module Jekyll
  class MediumPostDisplay < Generator
    safe true
    priority :high

    def generate(site)
      @post_titles = []
      jekyll_coll = Jekyll::Collection.new(site, 'medium_posts')
      site.collections['medium_posts'] = jekyll_coll

      Feedjira::Feed.fetch_and_parse("https://medium.com/feed/@nzvi").entries.each do |e|
        title = e.title
        content = e.content
        @post_titles << title
        puts title
        path = site.in_source_dir("_external_feed/#{title}.md")
        doc = Jekyll::Document.new(path, { :site => site, :collection => jekyll_coll })
        doc.data['title'] = title
        doc.data['feed_content'] = content
        jekyll_coll.docs << doc
        # site.docs << doc
      end
    end
  end
end

if is_standalone
  site = Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "./_site"
  }))
  
  generator = Jekyll::MediumPostDisplay.new
  generator.generate(site)
  puts "Fetched posts:"
  puts generator.instance_variable_get(:@post_titles).join("\n")
end