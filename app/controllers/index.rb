enable :sessions

get '/' do
  @login_fail = params[:login_fail]
  @user = session[:user_name]
  if @user
    puts @user
  end
  erb :index
end

get "/signup" do 
  erb :signup
end

post "/signup" do 
 @password_salt = BCrypt::Engine.generate_salt
 @password_hash = BCrypt::Engine.hash_secret(params[:password], @password_salt)

 User.create( :user_name => params[:user_name],
              :email => params[:email],
              :password_salt => @password_salt,
              :password_hash => @password_hash)

 session[:user_name] = params[:user_name]
 redirect "/"
end

post "/login" do 

  user = User.find_by_email(params[:email])

  redirect '/?login_fail=true' if user.nil?
  if user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
    session[:user_name] = user.user_name
    redirect"/"
  else
    redirect"/?login_fail=true"
  end
end

get "/logout" do 
  session[:user_name] = nil
  redirect "/"
end