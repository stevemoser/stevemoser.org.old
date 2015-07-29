require 'jekyll/post'
#require 'jekyll/reader'

module PostsWithoutDates
 

  # Used to remove #process so that it can be overridden
  def self.included(klass)
    klass.class_eval do
      remove_method :process
    end
  end

  def process(name)
      m, slug, ext = *name.match(/^(.*)(\.[^.]+)$/)
      #self.date = File.mtime(File.join(@base, name))
      self.slug = slug
      self.ext = ext
  end

end

module Jekyll  
  Post.send(:include, PostsWithoutDates)
end

module AllPostsValid

  # Used to remove #process so that it can be overridden
  def self.included(klass)
    klass.class_eval do
      remove_method :read_content
    end
  end
 
  def read_content(dir, magic_dir)
      @site.reader.get_entries(dir, magic_dir).map do |entry|
        Jekyll::Post.new(site, site.source, dir, entry)
      end.reject do |entry|
        entry.nil?
      end
  end
end

module Jekyll
    PostReader.send(:include, AllPostsValid)
end