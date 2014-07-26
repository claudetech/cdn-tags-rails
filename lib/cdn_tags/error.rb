module CdnTags
  class Error < StandardError
    attr_reader :object

    def initialize(object)
      @object = object
    end
  end
end
