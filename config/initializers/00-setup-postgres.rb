if ENV["RACK_ENV"] == "production"
  uri = URI.parse(ENV["DATABASE_URL"])
  config = {
    "production" => {
      "adapter"  => "postgres",
      "host"     => uri.host,
      "port"     => uri.port,
      "database" => uri.path.slice(1..-1),
      "username" => uri.user,
      "password" => uri.password,
      "sslmode"  => "require"
    }
  }
else
  config = YAML.load_file("config/database.yml")
end

DB = Sequel.postgres(config[Sinatra::Application.environment.to_s].reject { |key, value|
  key == "adapter"
})

