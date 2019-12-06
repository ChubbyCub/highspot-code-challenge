class User
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end

  def to_json
    return {
             "id" => @id,
             "name" => @name,
           }
  end
end
