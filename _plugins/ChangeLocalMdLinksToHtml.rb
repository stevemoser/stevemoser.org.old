# By Partly Cloudy
# http://stackoverflow.com/a/29234076/142358

module ChangeLocalMdLinksToHtml
  class Generator < Jekyll::Generator
    def generate(site)
      site.posts.each { |p| rewrite_links(site, p) }
    end
    def rewrite_links(site, post)
       post.content = post.content.gsub(/(\[[^\]]*\]\([^:\)]*)\.md\)/, '\1)')
       
    end
  end
end