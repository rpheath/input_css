require File.join(File.dirname(__FILE__), 'spec_helper')

describe "InputCSS" do
  AVH = ActionView::Helpers    
  
  describe "testing all valid INPUT types" do
    include AVH::TagHelper
    
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
    include AVH::TagHelper
        
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
      include AVH::FormTagHelper  
      
      it "should behave as expected (according to documentation) with the addition of default class" do
        text_field_tag('name').
          should eql("<input class=\"text\" id=\"name\" name=\"name\" type=\"text\" />")
        text_field_tag('query', 'Enter your search query here').
          should eql("<input class=\"text\" id=\"query\" name=\"query\" type=\"text\" value=\"Enter your search query here\" />")
        text_field_tag('request', nil, :class => 'special_input').
          should eql("<input class=\"special_input text\" id=\"request\" name=\"request\" type=\"text\" />")
        text_field_tag('address', '', :size => 75).
          should eql("<input class=\"text\" id=\"address\" name=\"address\" size=\"75\" type=\"text\" value=\"\" />")
        text_field_tag('zip', nil, :maxlength => 5).
          should eql("<input class=\"text\" id=\"zip\" maxlength=\"5\" name=\"zip\" type=\"text\" />")
        text_field_tag('payment_amount', '$0.00', :disabled => true).
          should eql("<input class=\"text\" disabled=\"disabled\" id=\"payment_amount\" name=\"payment_amount\" type=\"text\" value=\"$0.00\" />")
        text_field_tag('ip', '0.0.0.0', :maxlength => 15, :size => 20, :class => 'ip-input').
          should eql("<input class=\"ip-input text\" id=\"ip\" maxlength=\"15\" name=\"ip\" size=\"20\" type=\"text\" value=\"0.0.0.0\" />")
      end
    end
    
    describe "testing FormHelpers" do
      include AVH::FormHelper
      
      class Project
        attr_accessor :title, :is_complete
        def initialize(title, is_complete)
          @title, @is_complete = title, is_complete
        end
      end
      
      before(:each) do
        @project = Project.new('RPH', true)
      end
      
      # FormHelper#text_field
      it "should add default css to text_field" do
        text_field(:project, :title, :object => @project).
          should eql("<input class=\"text\" id=\"project_title\" name=\"project[title]\" size=\"30\" type=\"text\" value=\"RPH\" />")
      end
      
      it "should append css to existing css" do
        text_field(:project, :title, :object => @project, :class => 'project').
          should eql("<input class=\"project text\" id=\"project_title\" name=\"project[title]\" size=\"30\" type=\"text\" value=\"RPH\" />")
      end
      
      # FormHelper#hidden_field
      it "should not add css to hidden_field" do
        hidden_field(:project, :title, :object => @project).
          should eql("<input id=\"project_title\" name=\"project[title]\" type=\"hidden\" value=\"RPH\" />")
      end
      
      # FormHelper#password_field
      it "should add default css of 'text' to password_field" do
        password_field(:project, :title, :object => @project).
          should eql("<input class=\"text\" id=\"project_title\" name=\"project[title]\" size=\"30\" type=\"password\" value=\"RPH\" />")
      end
      
      it "should add default css of 'text' to password_field" do
        password_field(:project, :title, :object => @project, :class => 'project').
          should eql("<input class=\"project text\" id=\"project_title\" name=\"project[title]\" size=\"30\" type=\"password\" value=\"RPH\" />")
      end
      
      # FormHelper#check_box
      it "should add default css to check_box" do
        check_box(:project, :is_complete, :object => @project).
          should eql(
            "<input checked=\"checked\" class=\"checkbox\" id=\"project_is_complete\" name=\"project[is_complete]\" type=\"checkbox\" value=\"1\" />" +
            "<input name=\"project[is_complete]\" type=\"hidden\" value=\"0\" />"
          )
      end
      
      it "should add default css to check_box" do
        check_box(:project, :is_complete, :object => @project, :class => 'project').
          should eql(
            "<input checked=\"checked\" class=\"project checkbox\" id=\"project_is_complete\" name=\"project[is_complete]\" type=\"checkbox\" value=\"1\" />" +
            "<input name=\"project[is_complete]\" type=\"hidden\" value=\"0\" />"
          )
      end
      
      # FormHelper#radio_button
      it "should add default css to radio_button" do
        radio_button(:project, :is_complete, 'yes').
          should eql("<input class=\"radio\" id=\"project_is_complete_yes\" name=\"project[is_complete]\" type=\"radio\" value=\"yes\" />")
      end
      
      it "should add default css to radio_button" do
        radio_button(:project, :is_complete, 'yes', :class => 'project').
          should eql("<input class=\"project radio\" id=\"project_is_complete_yes\" name=\"project[is_complete]\" type=\"radio\" value=\"yes\" />")
      end
      
      # FormHelper#file_field
      it "should add default css to file_field" do
        file_field(:project, :chart).
          should eql("<input class=\"file\" id=\"project_chart\" name=\"project[chart]\" size=\"30\" type=\"file\" />")
      end
    end
  end
end