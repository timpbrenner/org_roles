require_relative 'root_organization'
require_relative 'role'
require_relative 'user'

describe BaseOrganization, '#add_role' do
  it 'Adding a role should add it to role list' do
    root = RootOrganization.new
    user = User.new

    role = root.add_role user, Role::ADMIN

    root.roles.count.should eq(1)
    root.roles.first.should eq(role)
  end
end

describe BaseOrganization, '#get_role' do
  it "Getting a role that doesn't exist returns nil" do
    root = RootOrganization.new
    user = User.new

    root.get_role(user).should eq(nil)
  end

  it "Retrieves role" do
    root = RootOrganization.new
    user = User.new

    role = root.add_role user, Role::ADMIN

    root.get_role(user).should eq(role)
  end
end
