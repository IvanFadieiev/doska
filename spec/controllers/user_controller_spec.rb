require 'spec_helper'

describe UsersController do
  it 'create' do
    # user = {
    #   user: 'Ivan', full_name: 'Fadieiev',
    #   birthday: '1991 - 03- 07', email: 'ivanfadeev91@gmail.com',
    #   adress: 'Chkalova', city: 'Kharkiv', country: 'Ukraine',
    #   password: '123456', password_confirmation: '123456'
    # }
    # post :create, user: user
    # new_user = User.find_by_user('Ivan')
    # new_user.should_not be_nil
    # expect(response).to redirect_to(assigns(:user))
    user = User.create(
      user: 'Ivan', full_name: 'Fadieiev',
      birthday: '1991 - 03- 07', email: 'ivanfadeev91@gmail.com',
      adress: 'Chkalova', city: 'Kharkiv', country: 'Ukraine',
      password: '123456', password_confirmation: '123456'
    )
    User.find(user.id).should_not be_nil
  end
  it 'new' do
    post :create, user: {
      full_name: 'Fadieiev',
      birthday: '1991 - 03- 07', email: 'ivanfadeev91@gmail.com',
      adress: 'Chkalova', city: 'Kharkiv', country: 'Ukraine',
      password: '123456', password_confirmation: '123456'
    }
    response.should render_template('new')
  end
end
