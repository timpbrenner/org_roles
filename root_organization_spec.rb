require_relative 'root_organization'
require_relative 'user'
require_relative 'role'

describe RootOrganization, '#add_child_organization' do
  it 'Adding an Organization should add it to child_organizations' do
    root = RootOrganization.new
    child = Organization.new

    root.add_child_organization child

    root.child_organizations.count.should eq(1)
    root.child_organizations.first.should eq(child)
  end

  it 'Child Organization should have the parent orginization set' do
    root = RootOrganization.new
    child = Organization.new

    root.add_child_organization child

    child.parent_organization.should eq(root)
  end

  it 'Should throw error if child is not Organization' do
    root = RootOrganization.new
    child = ChildOrganization.new

    expect { root.add_child_organization child }.to raise_error('Child must be Organization')
  end

  it 'Should throw error if child has parent' do
    root = RootOrganization.new
    child = Organization.new

    bad_parent = RootOrganization.new
    bad_parent.add_child_organization child

    expect { root.add_child_organization child }.to raise_error('Child can not have a parent')
  end
end

describe RootOrganization, '#check_role' do
  it "Getting a role that doesn't exist returns nil" do
    root = RootOrganization.new
    user = User.new

    root.check_role(user).should eq(nil)
  end

  it "Retrieves role" do
    root = RootOrganization.new
    user = User.new

    role = root.add_role user, Role::ADMIN

    root.check_role(user).should eq(role)
  end
end

describe RootOrganization, '#parent_organization' do
  it 'Should throw error when trying to set parent_organization' do
    root = RootOrganization.new
    parent = RootOrganization.new

    expect { root.parent_organization = parent }.to raise_error('Can not have a parent organization')
  end
end
