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

  def check_role user
    if role = get_role(user)
      role
    elsif parent_organization
      parent_organization.check_role(user)
    end
  end

  def add_child_organization org
    raise "Must be implemented in child class"
  end

private
  def get_role user
    #If these are ActiveRecord objects I would be doing id comparison, not object comparison
    @roles.find {|r| r.user == user }
  end

end
