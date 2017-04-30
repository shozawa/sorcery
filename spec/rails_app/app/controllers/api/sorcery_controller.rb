class API::SorceryController < ActionController::API
  before_action :require_login, only: [:some_action]

  def test_login
    @user = login(params[:email], params[:password])
    head :ok
  end

  def test_logout
    logout
    head :ok
  end

  def some_action
    head :ok
  end

  def test_auto_login
    user = User.first
    @result = auto_login(user)
    head :ok
  end

  def test_return_to
    login(params[:email], params[:password])
    redirect_back_or_to(root_path)
  end
end