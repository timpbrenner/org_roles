require_relative '../../lib/models/root_organization'
require_relative '../../lib/models/user'
require_relative '../../lib/models/role'

describe Organization do
  let(:root) { RootOrganization.new }
  let(:org) { Organization.new }
  let(:child) { ChildOrganization.new }
  let(:user) { User.new }

  describe '#add_child_organization' do
    it 'adds and organization to child_organizations' do
      org.add_child_organization child

      expect(org.child_organizations.count).to be(1)
      expect(org.child_organizations.first).to be(child)
    end

    it 'has the parent orginization set' do
      org.add_child_organization child

      expect(child.parent_organization).to be(org)
    end

    it 'throws an error if child is not Organization' do
      expect { org.add_child_organization Organization.new }.to raise_error('Child must be ChildOrganization')
    end

    it 'throws an error if child has parent' do
      bad_parent = Organization.new
      bad_parent.add_child_organization child

      expect { org.add_child_organization child }.to raise_error('Child can not have a parent')
    end
  end

  describe '#check_role' do
    before do
      root.add_child_organization org
    end

    it 'returns nil if no role exists' do
      expect(org.check_role(user)).to be(nil)
    end

    it 'returns a role for user' do
      role = org.add_role user, Role::ADMIN

      expect(org.check_role(user)).to be(role)
    end

    it "returns a root organization role for user if organization doesn't have one" do
      role = root.add_role user, Role::ADMIN

      expect(org.check_role(user)).to be(role)
    end

    it "returns an organization role for user and overwrite parent role" do
      role = org.add_role user, Role::ADMIN
      root.add_role user, Role::DENIED

      expect(org.check_role(user)).to be(role)
    end
  end

end
