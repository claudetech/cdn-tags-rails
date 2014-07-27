require 'active_support'

module CdnTags
  module Helpers
    def javascript_cdn_include_tag(*sources)
      options = sources.extract_options!
      mapped_sources = CdnTags.map_sources(sources, :scripts_urls)
      javascript_include_tag *mapped_sources, options
    end

    def stylesheet_cdn_link_tag(*sources)
      options = sources.extract_options!
      mapped_sources = CdnTags.map_sources(sources, :stylesheets_urls)
      stylesheet_link_tag *mapped_sources, options
    end
  end

  def self.map_sources(sources, config_key)
    config = CdnTags.configuration
    do_replace = config.cdn_environments.include? config.environment.to_sym
    return sources unless do_replace || config.should_raise
    sources.map do |s|
      src = config.send(config_key)[s]
      if src.nil?
        raise CdnTags::Error.new(config), "#{s} is not defined. Check CdnTags configuration." if config.should_raise
        s
      else
        do_replace ? src : s
      end
    end
  end

  def maybe_raise(src, config_key)
  end
end
