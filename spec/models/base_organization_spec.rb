require_relative '../../lib/models/root_organization'
require_relative '../../lib/models/role'
require_relative '../../lib/models/user'

describe BaseOrganization do
  let(:root) { RootOrganization.new }
  let(:user) { User.new }

  describe '#add_role' do
    before do
      @role = root.add_role user, Role::ADMIN
    end

    it 'Adding a role should add it to role list' do
      expect(root.roles.count).to be(1)
      expect(root.roles.first).to be(@role)
    end
  end

  describe '#get_role' do
    it "Getting a role that doesn't exist returns nil" do
      expect(root.check_role user).to be(nil)
    end

    it "Retrieves role" do
      role = root.add_role user, Role::ADMIN

      expect(root.check_role user).to be(role)
    end
  end
end
