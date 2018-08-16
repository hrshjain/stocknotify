class Ability
  include CanCan::Ability

  def initialize(admin_user)
    can [:read, :edit, :update, :destroy], AdminUser, id: admin_user.id
    can :create, AdminUser
    can :read, ActiveAdmin::Page, name: "Dashboard", namespace_name: "admin"
    can [:read, :edit, :update, :destroy], Notification, admin_user_id:  admin_user.id
    can :create, Notification
    can :read, ActiveAdmin::Page, name: "Help"
  end
end
