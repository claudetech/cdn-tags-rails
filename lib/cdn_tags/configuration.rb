require 'rails'

module CdnTags
  class Configuration
    attr_accessor :scripts_urls, :stylesheets_urls, :environment
    attr_accessor :raise_on_missing, :add_to_precompile

    def initialize
      self.scripts_urls = {}
      self.stylesheets_urls = {}
      self.environment = Rails.env
      self.raise_on_missing = false
      self.add_to_precompile = true
    end

    def update_rails_precompile!
      return unless self.add_to_precompile
      scripts_precompile = self.scripts_urls.keys.map { |s| File.extname(s) == '' ? "#{s}.js" : s }
      stylesheets_precompile = self.stylesheets_urls.keys.map { |s| File.extname(s) == '' ? "#{s}.css" : s }
      added_precompile = scripts_precompile + stylesheets_precompile
      Rails.application.config.assets.precompile += added_precompile
    end
  end
end
