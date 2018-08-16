ActiveAdmin.register_page "Help" do


  content :title => "Help Center" do
    render partial: "help_page"
  end

  menu label: "Help Center"

  #remove breadcrumb
  breadcrumb do
  end


  #index title: "me new title"
  #index :title => 'Help Center'
end
