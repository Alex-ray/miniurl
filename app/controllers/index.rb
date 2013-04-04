enable :sessions

get '/' do
  @user = session[:user_id].nil? ? nil : User.find(session[:user_id]) 
  @login_fail = params[:login_fail]
  if !@user.nil?
    @user_urls = @user.urls
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

 user = User.find_by_email(params[:email])
 session[:user_name] = user.id
 redirect "/"
end

post "/login" do 

  user = User.find_by_email(params[:email])

  redirect '/?login_fail=true' if user.nil?
  if user.password_hash == BCrypt::Engine.hash_secret(params[:password], user.password_salt)
    session[:user_id] = user.id
    p user.id
    redirect"/"
  else
    redirect"/?login_fail=true"
  end

end

get "/logout" do 

  session[:user_id] = nil
  redirect "/"

end

get '/url' do 

  if session[:user_id].nil?
    redirect to '/?login_fail=true'
  else
    @user = User.find(session[:user_id])
    @long_url = params[:long_url]
    @short_url = shortener(@long_url)
    @user.urls.create(long_url: @long_url, short_url: @short_url)
    redirect to "/"
  end

end

get '/short/:short_url' do 

  shorty = params[:short_url]
  url_object = Url.where("short_url = ?", shorty).first
  long_url = url_object.url
  url_object.click_counter += 1
  url_object.save
  redirect to long_url

end

def shortener(url)
  short_url = SecureRandom.hex(4)
  shortener(url) if Url.exists?(short_url: short_url)
  short_url
end