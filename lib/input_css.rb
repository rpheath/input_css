# Modifies the 'options' of the tag helper so that, by default,
# there's a CSS class attribute based on the type attribute
# (Note: only applies to input fields)
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
          options = HashWithIndifferentAccess.new(options)
          return options if options[:type] == 'hidden'

          # alter CSS class based on type 
          # (only for <input ... /> tags)
          if name.to_s.downcase =~ /^input$/            
            type, css = options[:type], options[:class]
            type = 'text' if type == 'password'
            options[:class] = "#{css.to_s} #{type.to_s}".gsub!(/^\s*/, '') unless css && css.split.include?(type)
          end
          options
        end
    end
    
    # ensure that the new #tag_with_default_css
    # method is always called
    class InstanceTag
      alias_method :tag_without_error_wrapping, :tag_with_default_css
    end
  end
end
