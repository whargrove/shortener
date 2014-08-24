require "uri"

class Validator

  # All URLs should confirm to this pattern
  @@pattern = URI.regexp

  def self.validate(string)
    string =~ @@pattern
  end

end
