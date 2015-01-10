require_relative 'root_organization'
require_relative 'user'
require_relative 'role'

describe Organization, '#add_child_organization' do
  it 'Adding an Organization should add it to child_organizations' do
    root = Organization.new
    child = ChildOrganization.new

    root.add_child_organization child

    root.child_organizations.count.should eq(1)
    root.child_organizations.first.should eq(child)
  end

  it 'Child Organization should have the parent orginization set' do
    org = Organization.new
    child = ChildOrganization.new

    org.add_child_organization child

    child.parent_organization.should eq(org)
  end

  it 'Should throw error if child is not Organization' do
    root = Organization.new
    child = Organization.new

    expect { root.add_child_organization child }.to raise_error('Child must be ChildOrganization')
  end

  it 'Should throw error if child has parent' do
    root = Organization.new
    child = ChildOrganization.new

    bad_parent = Organization.new
    bad_parent.add_child_organization child

    expect { root.add_child_organization child }.to raise_error('Child can not have a parent')
  end
end

describe Organization, '#check_role' do
  it 'Should return nil if no role exists' do
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org

    org.check_role(user).should eq(nil)
  end

  it 'Should return role for user' do
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    role = org.add_role user, Role::ADMIN

    org.check_role(user).should eq(role)
  end

  it "Should return root organization role for user if organization doesn't have one" do
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    role = root.add_role user, Role::ADMIN

    org.check_role(user).should eq(role)
  end

  it "Should return organization role for user and overwrite parent role" do
    org = Organization.new
    root = RootOrganization.new
    user = User.new

    root.add_child_organization org
    root_role = root.add_role user, Role::ADMIN
    role = org.add_role user, Role::DENIED

    org.check_role(user).should eq(role)
  end
end
