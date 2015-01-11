require_relative 'base_organization'

class ChildOrganization < BaseOrganization

  def add_child_organization org
    raise 'Can not add children to a Child Organization'
  end

end
