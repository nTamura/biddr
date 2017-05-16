class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    can :manage, Auction do |a|
      a.user == user
    end

    can :favorite, Auction do |a|
      user != a.user
    end

    cannot :favorite, Auction do |a|
      user == a.user
    end

    can [:edit, :destroy], Auction do |a|
      a.user == user
    end
  end
end
