class WwwMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if !request.host.starts_with?("www")
      [301, {"Location" => "www.higheaglestudios.com"}, self]
      # [301, {"Location" => "http://www.higheaglestudios.com"}, self]
    else
      @app.call(env)
    end
  end

  def each(&block)
  end
end
