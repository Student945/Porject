# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user||= User.new

  if user.new_record?
    can :create, User
  end

if user.present?

    can :create, Relationship, follower_id: user.id
    can :destroy, Relationship, follower_id: user.id
    can :destroy, Research, user_id: user.id
    can :create, Research, user_id: user.id
    can :read, Research
    can :read, User
    can :destroy, User, id: user.id
    can :update, User, id: user.id
    can :create, Review, user_id: user.id
    can :read, Review
    can :destroy, Review, user_id: user.id
    can :update, Review, user_id: user.id
    can :create, Message, user_id: user.id
    can :feedordina, Research, user_id: user.id
    can :ordina, Research, user_id: user.id
end

if user.moderator?
    can :read, User
    can :destroy, User
    can :destroy, Review
    can :update, Review
    can :read, Review
    can :read, Research
    can :destroy, Message
    can :admin_board, User
    can :read, Message

end

if user.admin?
    can :manage, Message
    can :manage, Review
    can :manage, User
    can :manage, Research
end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md

    
  end

end