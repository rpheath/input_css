require File.join(File.dirname(__FILE__), 'spec_helper')

describe "InputCSS" do
  include ActionView::Helpers::TagHelper
  
  describe "testing all valid INPUT types" do
    VALID_TYPES = %w[text submit reset checkbox radio file image button]
    
    VALID_TYPES.each do |type|
      it "should have class='#{type}' for type='#{type}'" do
        tag('input', { :type => type }).
          should eql("<input class=\"#{type}\" type=\"#{type}\" />")
      end
    end
    
    it "should have class='text' for type='password'" do
      tag('input', { :type => 'password' }).
        should eql("<input class=\"text\" type=\"password\" />")
    end
    
    it "should not have a class attribute for type='hidden'" do
      tag('input', {:type => 'hidden'}).
        should eql("<input type=\"hidden\" />")
    end
  end
  
  # (http://www.noobkit.com/show/ruby/rails/rails-stable/actionpack/actionview/helpers/taghelper/tag.html)
  describe "ActionView::Helpers" do    
    describe "use examples shown in TagHelper#tag documentation" do
      it "should not add a default class attribute to non-INPUT tags" do
        tag('br').should eql("<br />")
        tag('br', nil, true).should eql("<br>")
        tag('img', {:src => 'open & shut.png'}).
          should eql("<img src=\"open &amp; shut.png\" />")
        tag('img', {:src => 'open &amp; shut.png'}, false, false).
          should eql("<img src=\"open &amp; shut.png\" />")
      end
    end
    
    # (http://www.noobkit.com/show/ruby/rails/rails-stable/actionpack/actionview/helpers/formtaghelper/text_field_tag.html)
    describe "use examples shown in FormTagHelper#text_field_tag documentation" do
      include ActionView::Helpers::FormTagHelper  
      
      it "should behave as expected (according to documentation) with the addition of default class" do
        text_field_tag('name').
          should eql("<input class=\"text\" id=\"name\" name=\"name\" type=\"text\" />")
        text_field_tag('query', 'Enter your search query here').
          should eql("<input class=\"text\" id=\"query\" name=\"query\" type=\"text\" value=\"Enter your search query here\" />")
        text_field_tag('request', nil, :class => 'special_input').
          should eql("<input id=\"request\" name=\"request\" type=\"text\" />")
        text_field_tag('address', '', :size => 75).
          should eql("<input class=\"text\" id=\"address\" name=\"address\" size=\"75\" type=\"text\" value=\"\" />")
        text_field_tag('zip', nil, :maxlength => 5).
          should eql("<input class=\"text\" id=\"zip\" maxlength=\"5\" name=\"zip\" type=\"text\" />")
        text_field_tag('payment_amount', '$0.00', :disabled => true).
          should eql("<input class=\"text\" disabled=\"disabled\" id=\"payment_amount\" name=\"payment_amount\" type=\"text\" value=\"$0.00\" />")
        text_field_tag('ip', '0.0.0.0', :maxlength => 15, :size => 20, :class => 'ip-input').
          should eql("<input id=\"ip\" maxlength=\"15\" name=\"ip\" size=\"20\" type=\"text\" value=\"0.0.0.0\" />")
      end
    end
  end
end