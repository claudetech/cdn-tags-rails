require File.join(File.dirname(__FILE__), 'spec_helper')
require 'cdn_tags'

def script_src(html)
  doc = Nokogiri::HTML(html)
  doc.xpath('//script')[0].attr('src')
end

def link_href(html)
  doc = Nokogiri::HTML(html)
  doc.xpath('//link')[0].attr('href')
end

describe CdnTags do
  describe CdnTags::Configuration do
    it 'should have default values' do
      expect(CdnTags.configuration.stylesheets_urls).to eq({})
      expect(CdnTags.configuration.scripts_urls).to eq({})
    end

    it 'should bet settable' do
      CdnTags.configure do |c|
        c.scripts_urls["foo"] = "bar"
      end
      expect(CdnTags.configuration.scripts_urls["foo"]).to eq("bar")
    end

    it 'should update Rails assets precompile' do
      expect(Rails.application.config.assets.precompile).not_to include('jquery.js')
      expect(Rails.application.config.assets.precompile).not_to include('bootstrap.css')
      CdnTags.configure do |c|
        c.scripts_urls["jquery"] = "foobar"
        c.stylesheets_urls["bootstrap"] = "foobar"
      end
      expect(Rails.application.config.assets.precompile).to include('jquery.js')
      expect(Rails.application.config.assets.precompile).to include('bootstrap.css')
    end

    it 'should not update Rails assets precompile if disabled' do
      expect(Rails.application.config.assets.precompile).not_to include('angular.js')
      CdnTags.configure do |c|
        c.scripts_urls["angular"] = "foobar"
        c.add_to_precompile = false
      end
      expect(Rails.application.config.assets.precompile).not_to include('angular.js')
    end
  end

  describe CdnTags::Helpers do
    view = ActionView::Base.new
    subject { view }

    before(:each) do
      CdnTags.configure do |c|
        c.scripts_urls = {
          'jquery' => '//code.jquery.com/jquery-2.1.1.min.js',
        }
        c.stylesheets_urls = {
          'bootstrap' => '//maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css'
        }
        c.raise_on_missing = false
      end
    end

    tests = [
      {
        method: 'javascript_cdn_include_tag',
        path_helper: 'javascript_path',
        extracter: 'script_src',
        asset: 'jquery',
        config_key: 'scripts_urls'
      },
      {
        method: 'stylesheet_cdn_link_tag',
        path_helper: 'stylesheet_path',
        extracter: 'link_href',
        asset: 'bootstrap',
        config_key: 'stylesheets_urls'
      }
    ]

    tests.each do |t|
      it { should respond_to(t[:method]) }

      describe "##{t[:method]}" do
        it 'should not replace sources in development and test envs' do
          CdnTags.configuration.environment = "development"
          tag = view.send(t[:method], "foo")
          expected = view.send(t[:path_helper], "foo")
          expect(send(t[:extracter], tag)).to eq(expected)
        end

        it 'should replace sources in production' do
          CdnTags.configuration.environment = "production"
          tag = view.send(t[:method], t[:asset])
          urls = CdnTags.configuration.send(t[:config_key])
          expected = urls[t[:asset]]
          expect(send(t[:extracter], tag)).to eq(expected)
        end

        it 'should ignore unconfigured sources' do
          CdnTags.configuration.environment = "production"
          tag = view.send(t[:method], "foo")
          expected = view.send(t[:path_helper], "foo")
          expect(send(t[:extracter], tag)).to eq(expected)
        end

        it 'should raise error when configured' do
          CdnTags.configure do |c|
            c.raise_on_missing = true
          end
          CdnTags.configuration.environment = "production"
          expect { view.send(t[:method], "foo") }.to raise_error(CdnTags::Error)
        end
      end
    end
  end
end
