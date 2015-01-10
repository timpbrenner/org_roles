require_relative 'role'
require_relative 'user'

describe Role, '#new' do
  it 'should populate user, and permission' do
    user = User.new
    role = Role.new user, Role::ADMIN

    role.user.should eq(user)
    role.permission.should eq(Role::ADMIN)
  end

  it 'Admin permissions should flag admin' do
    user = User.new
    role = Role.new user, Role::ADMIN

    role.admin?.should eq(true)
    role.user?.should eq(false)
    role.denied?.should eq(false)
  end

  it 'User permissions should flag user' do
    user = User.new
    role = Role.new user, Role::USER

    role.user?.should eq(true)
    role.admin?.should eq(false)
    role.denied?.should eq(false)
  end

  it 'Denied permissions should flag denied' do
    user = User.new
    role = Role.new user, Role::DENIED

    role.denied?.should eq(true)
    role.user?.should eq(false)
    role.admin?.should eq(false)
  end
end
