require 'rails'

module CdnTags
  class Configuration
    attr_accessor :scripts_urls, :stylesheets_urls, :environment
    attr_accessor :raise_on_missing, :add_to_precompile, :cdn_environments
    attr_reader :should_raise

    def initialize
      self.scripts_urls = {}
      self.stylesheets_urls = {}
      self.environment = Rails.env
      self.raise_on_missing = false
      self.add_to_precompile = true
      self.cdn_environments = [:production]
    end

    def post_configure_hooks
      update_rails_precompile!
      fix_keys!
      set_should_raise!
    end

    private
    def set_should_raise!
      if self.raise_on_missing == !!self.raise_on_missing
        @should_raise = self.raise_on_missing
      else
        self.raise_on_missing.map! { |s| s.to_sym }
        @should_raise = self.raise_on_missing.include? self.environment
      end
    end

    def fix_keys!
      self.cdn_environments.map! { |s| s.to_sym }
      self.environment = self.environment.to_sym
    end

    def update_rails_precompile!
      return unless self.add_to_precompile
      scripts_precompile = self.scripts_urls.keys.map { |s| should_append_extension(s) ? "#{s}.js" : s }
      stylesheets_precompile = self.stylesheets_urls.keys.map { |s| should_append_extension(s) ? "#{s}.css" : s }
      added_precompile = scripts_precompile + stylesheets_precompile
      Rails.application.config.assets.precompile += added_precompile
    end

    def should_append_extension(filename)
      extname = File.extname(filename)
      extname.empty? or /[0-9]+/.match extname[1..-1]
    end
  end
end
