class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    can :favorite, Auction do |a|
      user != a.user
    end

    cannot :favorite, Auction do |a|
      user == a.user
    end

    can [:edit, :destroy], Auction do |auction|
      auction.user == user
    end
  end
end
