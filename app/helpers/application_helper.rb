# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end
  
  def header(&block)
    concat(content_tag(:div, :class => "header") do
        capture(&block)
        
    end + content_tag(:p, :class => "notify") do flash[:notice] end)
  end

  def production?
    @is_production ||=(ENV['RAILS_ENV']=='production')
  end

  def version
    '1.0'
  end
  
  def real_currency(number)
    number_to_currency(number,:delimiter => ",", :unit => "$ ",:separator => ".")
  end
  
  def body_css
    if current_user.nil?
      "class='logged_out'" 
    elsif current_user.user_type == UserType::ADMIN
      "class='admin'"
    end
  end
  
  def integrity_about
    title = "Integrity Systems & Solutions"
    
    link_to_function title, 
                     about(title, "integrity")
  end
  
  def dss_about
    title = "Duck Soup Software"
    
    link_to_function title, 
                     about(title, "dss")
  end
  
  def about(title, div_id)
    "Modalbox.show($('#{div_id}'), {title: 'About #{title}', width: 650}); return false;"
  end
end
