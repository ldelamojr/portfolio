module Portfolio
  class Server < Sinatra::Base
    get "/" do
      erb :index
    end

    get "/contact" do
    	erb :contact
    end

    get "/about" do
        erb :about
    end

    post "/contact" do
    	# binding.pry
    	name = @params["name"]
    	email = params["email"]      #WITH OR WITHOUT THE @ CHARACTER
    	message = @params["message"]  #DEPENDING ON SCOPE YOU DESIRE

    	if ENV["RACK_ENV"] == 'production'
            conn = PG.connect(
                dbname: ENV["POSTGRES_DB"],
                host: ENV["POSTGRES_HOST"],
                password: ENV["POSTGRES_PASS"],
                user: ENV["POSTGRES_USER"]
            )
        else
            conn = PG.connect(dbname: "portfolio")
        end
    	#conn.exec("INSERT INTO contact_data (name, email, message) VALUES ('#{name}', '#{email}', '#{message}')")
    	conn.exec_params("INSERT INTO contact_data (name, email, message) VALUES ($1,$2,$3)",
    	[name, email, message])
    	
    	@contact_submitted = true

    	erb :contact

    	
    end


  end
end
