require_relative '../../lib/models/role'
require_relative '../../lib/models/user'

describe Role do
  let(:user) { User.new }
  let(:admin_role) { Role.new user, Role::ADMIN }
  let(:user_role) { Role.new user, Role::USER }
  let(:denied_role) { Role.new user, Role::DENIED }

  describe '#new' do
    it 'populates user, and permission' do
      expect(admin_role.user).to be(user)
      expect(admin_role.permission).to be(Role::ADMIN)
    end

    it 'Admin permissions should flag admin' do
      expect(admin_role).to be_admin
      expect(admin_role).not_to be_user
      expect(admin_role).not_to be_denied
    end

    it 'User permissions should flag user' do
      expect(user_role).not_to be_admin
      expect(user_role).to be_user
      expect(user_role).not_to be_denied
    end

    it 'Denied permissions should flag denied' do
      expect(denied_role).not_to be_admin
      expect(denied_role).not_to be_user
      expect(denied_role).to be_denied
    end
  end
end
