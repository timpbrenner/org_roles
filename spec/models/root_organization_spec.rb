require_relative '../../lib/models/root_organization'
require_relative '../../lib/models/user'
require_relative '../../lib/models/role'

describe RootOrganization do
  let(:root) { RootOrganization.new }
  let(:org) { Organization.new }
  let(:child) { ChildOrganization.new }
  let(:user) { User.new }

  describe '#add_child_organization' do
    it 'adds an Organization to child_organizations' do
      root.add_child_organization org

      expect(root.child_organizations.count).to be(1)
      expect(root.child_organizations.first).to be(org)
    end

    it 'Child Organization should have the parent orginization set' do
      root.add_child_organization org

      expect(org.parent_organization).to be(root)
    end

    it 'Should throw error if child is not Organization' do
      expect { root.add_child_organization child }.to raise_error('Child must be Organization')
    end

    it 'Should throw error if child has parent' do
      bad_parent = RootOrganization.new
      bad_parent.add_child_organization org

      expect { root.add_child_organization org }.to raise_error('Child can not have a parent')
    end
  end

  describe '#check_role' do
    it "gets a role that doesn't exist and returns nil" do
      expect(root.check_role(user)).to be(nil)
    end

    it "Retrieves role" do
      role = root.add_role user, Role::ADMIN

      expect(root.check_role(user)).to be(role)
    end
  end

  describe '#parent_organization' do
    it 'Should throw error when trying to set parent_organization' do
      parent = RootOrganization.new

      expect { root.parent_organization = parent }.to raise_error('Can not have a parent organization')
    end
  end
end
