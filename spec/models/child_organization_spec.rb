require_relative '../../lib/models/root_organization'
require_relative '../../lib/models/user'
require_relative '../../lib/models/role'

describe ChildOrganization do
  let(:root) { RootOrganization.new }
  let(:org) { Organization.new }
  let(:child) { ChildOrganization.new }
  let(:user) { User.new }

  describe '#add_child_organization' do
    it 'throws an error' do
      expect { child.add_child_organization ChildOrganization.new }.to raise_error('Can not add children to a Child Organization')
    end
  end

  describe '#check_role' do
    before do
      root.add_child_organization org
      org.add_child_organization child
    end

    it 'returns nil if no role exists' do
      expect(org.check_role(user)).to be_nil
    end

    it 'returns role for user' do
      role = child.add_role user, Role::ADMIN

      expect(child.check_role(user)).to eq(role)
    end

    it "returns a root organization role for user if organization doesn't have one" do
      role = root.add_role user, Role::ADMIN

      expect(child.check_role(user)).to eq(role)
    end

    it "returns an organization role for user and overwrite parent role" do
      root.add_role user, Role::ADMIN
      org.add_role user, Role::USER
      role = child.add_role user, Role::DENIED

      expect(child.check_role(user)).to eq(role)
    end
  end
end
