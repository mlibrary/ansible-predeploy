require_relative "./variable_declaration"

class Requirements
  # The single responsibility of this class is to represent
  # the required variables given a set of role configs.

  def initialize(raw_configs, excluded_roles = [])
    @declarations = build_declarations(raw_configs, excluded_roles)
    @globals_declarations = globals_to_declarations(@declarations)
  end
  attr_reader :declarations, :globals_declarations


  private

  def build_declarations(raw_configs, excluded_roles)
    raw_configs.keep_if {|k, _| !excluded_roles.include? k }
    raw_configs
      .map{|pair| vars_from_raw(pair[0], pair[1])}
      .reduce(:concat)
  end


  # Build variable declarations from the raw config for a role
  def vars_from_raw(tag, roles_to_config)
    roles_to_config
      .map{|role_config_hash| role_config_hash.to_a }
      .map{|var_value_pair| VariableDeclaration.from_anything(tag, var_value_pair[0], var_value_pair[1])}
  end


  # Build a map of global_names to Array<VariableDeclaration>
  def globals_to_declarations(declarations)
    globals_to_vars = Hash.new { [] }
    declarations.each do |declaration|
      key = declaration.global_name
      globals_to_vars[key] = globals_to_vars[key] << declaration
    end
    return globals_to_vars
  end

end


