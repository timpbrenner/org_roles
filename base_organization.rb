class BaseOrganization
  attr_accessor :child_organizations, :parent_organization, :roles

  def initialize
    @child_organizations = []
    @roles = []
  end

  def add_role user, permission
    role = Role.new user, permission
    @roles << role

    role
  end

  def get_role user
    @roles.find {|r| r.user == user }
  end

  def add_child_organization org
    raise "Must be implemented in child class"
  end

  def check_role user
    raise "Must be implemented in child class"
  end
end
