require_relative 'base_organization'

class ChildOrganization < BaseOrganization

  def add_child_organization org
    raise 'Can not add children to a Child Organization'
  end

  def check_role user
    return get_role(user) || parent_organization.check_role(user)
  end

end
