require 'sinatra/base'
require 'haml'
require 'thread'
require 'set'


LOGGED_IN_USERS = SortedSet.new
MUTEX = Mutex.new

class Application < Sinatra::Base
  set :root, File.join(File.dirname(__FILE__), '..')
  set :public, File.join(root, 'public')

  enable :sessions

  get '/login/:user?' do
    session[:user] = params[:user]
    mutex.synchronize {
      LOGGED_IN_USERS << session[:user]
    }
    haml :index
  end

  get '/' do
    session[:user] ||= "anonymous"
    haml :index
  end

  helpers do
    def logged_in_users
      LOGGED_IN_USERS
    end

    def mutex
      MUTEX
    end

    def all_users
      mutex.synchronize {
        LOGGED_IN_USERS.to_a.join(", ");
      }
    end
  end

end
