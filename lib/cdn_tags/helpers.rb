require 'active_support'

module CdnTags
  module Helpers
    def javascript_cdn_include_tag(*sources)
      options = sources.extract_options!
      mapped_sources = CdnTags.map_sources(sources)
      javascript_include_tag *mapped_sources, options
    end

    def stylesheet_cdn_link_tag(*sources)
      options = sources.extract_options!
      mapped_sources = CdnTags.map_sources(sources)
      stylesheet_link_tag *mapped_sources, options
    end
  end

  def self.map_sources(sources)
    config = CdnTags.configuration
    return sources unless config.environment.to_sym == :production
    sources.map do |s|
      src = config.urls[s]
      if src.nil?
        raise CdnTags::Error.new(config), "#{s} is not defined. Check CdnTags configuration." if config.raise_on_missing
        s
      else
        src
      end
    end
  end
end
