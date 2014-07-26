class CdnTags::Install < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def copy_initializer_file
    copy_file "cdn_tags.rb", "config/initializers/cdn_tags.rb"
  end
end
