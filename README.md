# CdnTags

Using a CDN in development is kind of painful when the 
network is unstable, however in production common libraries
should generally be served via a CDN.
This gem helps to automatize this process.

## Installation

Add 

```
gem 'cdn_tags'
```

to your Gemfile.

## Configuration

Create config/initializers/cdn_tags.rb and configure your assets.

```ruby
CdnTags.configure do |c|
  c.scripts_urls = {
    '/path/to/jquery' => '//code.jquery.com/jquery-2.1.1.min.js',
  }
  c.stylesheets_urls = {
    '/path/to/bootstrap' => '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'
  }
end
```

This will automatically add the files to `Rails.application.config.assets.precompile`. If you want to disable this behavior, you can set
`add_to_precompile` to `false` in the configuration.

## Usage

Just replace `javascript_include_tag` and `stylesheet_link_tag`
by `javascript_cdn_include_tag` and `stylesheet_cdn_link_tag`.

For example, 

```erb
<%= javascript_include_tag '/path/to/jquery' %>
<%= stylesheet_link_tag '/path/to/bootstrap' %>
```

becomes 

```erb
<%= javascript_cdn_include_tag '/path/to/jquery' %>
<%= stylesheet_cdn_link_tag '/path/to/bootstrap' %>
```
