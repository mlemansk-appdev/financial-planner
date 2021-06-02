class AdjustmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user)
    end
  end

  def show?
    user.id == record.user_id
  end

  def create?
    true
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end