class Role
  attr_accessor :user, :permission

  ADMIN = 0
  USER = 1
  DENIED = 2

  def admin?; permission == ADMIN; end
  def user?; permission == USER; end
  def denied?; permission == DENIED; end

  def initialize(user, permission)
    @user = user
    @permission = permission

  end
end
