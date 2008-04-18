module ActionView
  module Helpers
    module TagHelper
      # intercept #tag method to modify the 'options'
      def tag_with_default_css(name, options=nil, open=false, escape=true)
        options = css_options_for_tag(name, options)
        tag_without_default_css(name, options, open, escape)
      end
      
      # save the original method
      alias_method_chain :tag, :default_css
      
      private
        def css_options_for_tag(name, options)
          options.symbolize_keys!
          return options if options[:type] == 'hidden'

          # alter CSS class based on type 
          # (only for <input ... /> tags)
          if name.to_s.downcase =~ /^input$/            
            type, css = options[:type], options[:class]
            options[:class] = "#{css.to_s} #{type.to_s}" unless css && css.split.include?(type)
          end
          options.stringify_keys!
        end
    end
    
    # ensure that the new #tag method is always called
    class InstanceTag
      alias_method :tag_without_error_wrapping, :tag_with_default_css
    end
  end
end
