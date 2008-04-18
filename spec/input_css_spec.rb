require File.join(File.dirname(__FILE__), 'spec_helper')

describe "InputCSS" do
  include ActionView::Helpers::TagHelper
  
  describe "ActionView::Helpers" do    
    describe "use examples shown in TagHelper#tag documentation" do
      # (http://www.noobkit.com/show/ruby/rails/rails-stable/actionpack/actionview/helpers/taghelper/tag.html)
      it "should not add a default class attribute to non-input tags" do
        tag('br').should eql("<br />")
        tag('br', nil, true).should eql("<br>")
        tag('img', {:src => 'open & shut.png'}).
          should eql("<img src=\"open &amp; shut.png\" />")
        tag('img', {:src => 'open &amp; shut.png'}, false, false).
          should eql("<img src=\"open &amp; shut.png\" />")
      end
    end
  end
end