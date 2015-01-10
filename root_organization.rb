require_relative 'base_organization'
require_relative 'organization'

class RootOrganization < BaseOrganization

  def parent_organization= val
    raise "Can not have a parent organization"
  end

  def add_child_organization org
    raise 'Child must be Organization' unless org.is_a? Organization
    raise 'Child can not have a parent' unless org.parent_organization.nil?

    @child_organizations << org
    org.parent_organization = self
  end

  def check_role user
    get_role user
  end

end
