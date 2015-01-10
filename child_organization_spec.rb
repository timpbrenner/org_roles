require_relative 'root_organization'
require_relative 'user'
require_relative 'role'

describe ChildOrganization, '#add_child_organization' do
  it 'Should throw error' do
    org = ChildOrganization.new
    child = ChildOrganization.new

    expect { org.add_child_organization child }.to raise_error('Can not add children to a Child Organization')
  end
end

describe ChildOrganization, '#check_role' do
  it 'Should return nil if no role exists' do
    child = ChildOrganization.new
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    org.add_child_organization child

    org.check_role(user).should eq(nil)
  end

  it 'Should return role for user' do
    child = ChildOrganization.new
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    org.add_child_organization child

    role = child.add_role user, Role::ADMIN

    child.check_role(user).should eq(role)
  end

  it "Should return root organization role for user if organization doesn't have one" do
    child = ChildOrganization.new
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    org.add_child_organization child
    role = root.add_role user, Role::ADMIN

    child.check_role(user).should eq(role)
  end

  it "Should return organization role for user and overwrite parent role" do
    child = ChildOrganization.new
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    org.add_child_organization child

    root.add_role user, Role::ADMIN
    org.add_role user, Role::USER
    role = child.add_role user, Role::DENIED

    child.check_role(user).should eq(role)
  end
end

