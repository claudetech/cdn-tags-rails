CdnTags.configure do |c|
  # Add scripts using CDN here
  c.scripts_urls = {
    # 'jquery-1.9.1' => 'http://code.jquery.com/jquery-1.9.1.js'
  }

  # Add stylesheets using CDN here
  c.stylesheets_urls = {
    # 'bootstrap' => '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'
  }

  # Set to true to raise an exception if the demanded
  # asset is not defined above
  # c.raise_on_missing = false

  # Set to false to avoid adding the above assets
  # to Rails.config.assets.precompile automatically
  # c.add_to_precompile = true


  # Modify this array to set in which environments
  # should CDN be used
  # c.cdn_environments = [:production]
end
