module Ads
  module Rails
    module ActionView
      module Base

        def google_adsense_include_tag(*args)
          options = args.extract_options!
          # first check for a special proc
          if ::Rails.application.config.ads.renderer.is_a? Proc
            instance_exec(options, &::Rails.application.config.ads.renderer)
          else
            script = <<-SCRIPT
              google_ad_client = '#{options[:client]}';
              google_ad_slot = '#{options[:slot]}'; 
              google_ad_width = #{options[:width]};
              google_ad_height = #{options[:height]};
            SCRIPT
            content_tag(:script, script.html_safe, type: 'text/javascript') +
            content_tag(:script, nil, type: 'text/javascript', src: "#{request.protocol}pagead2.googlesyndication.com/pagead/show_ads.js")
          end
        end

      end
    end
  end
end
