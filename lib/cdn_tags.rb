%w{error configuration helpers}.each do |m|
  require File.join(File.dirname(__FILE__), 'cdn_tags', m)
end

module CdnTags
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield self.configuration
    self.configuration.update_rails_precompile!
  end

  def self.included(base)
    CdnTags.configuration { |c| nil }
    base.send :include, Helpers
  end
end

ActionView::Base.send(:include, CdnTags) if defined?(ActionView::Base)
