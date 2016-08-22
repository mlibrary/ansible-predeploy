require_relative "./variable_declaration"

class ResolvedVariable
  def initialize(role_variable_name, value)
    @role_name = role_variable_name
    @value = value
  end

  def to_h
    {@role_name => @value}
  end
end

