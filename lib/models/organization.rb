require_relative 'base_organization'
require_relative 'child_organization'

class Organization < BaseOrganization

  def add_child_organization org
    raise 'Child must be ChildOrganization' unless org.is_a? ChildOrganization
    raise 'Child can not have a parent' unless org.parent_organization.nil?

    @child_organizations << org
    org.parent_organization = self
  end

end
