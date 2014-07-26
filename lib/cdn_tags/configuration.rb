require 'rails'

module CdnTags
  class Configuration
    attr_accessor :urls, :environment, :raise_on_missing

    def initialize
      self.urls = {}
      self.environment = Rails.env
      self.raise_on_missing = false
    end
  end
end
