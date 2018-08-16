ActiveAdmin.register_page "Dashboard" do

  menu priority: 2, label: proc{ I18n.t("active_admin.dashboard") }

  breadcrumb do
    [
      link_to('User', 'admin_users')
    ]
  end
  
  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
  end
  # content title: proc{ I18n.t("active_admin.dashboard") } do
  #   div class: "blank_slate_container", id: "dashboard_default_message" do
  #     span class: "blank_slate" do
  #       span I18n.t("active_admin.dashboard_welcome.welcome")
  #       small I18n.t("active_admin.dashboard_welcome.call_to_action")
  #     end
  #   end

  controller do
    def index
      subscribed_stocks = current_admin_user.notifications.pluck(:stock_symbol)
      @stock_list = Stock.all.select {|stock| subscribed_stocks.include? (stock.symbol)}
      @date_list = BimonthlyDate.all
      @stock_date_price_list = BimonthlyDateStockPrice.select { |record| subscribed_stocks.include? Stock.find_by_id(record.stock_id).symbol}
    end
  end

  content do
    render partial: 'stock_graphs'
  end



    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  # end # content
end
