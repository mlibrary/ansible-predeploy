require_relative "./variable_declaration"

# Resolves variables given a completed set of globals
#
# Known limitations:
#   does not check for implicit globals
#   cannot specify more than one global
#   defaults cannot reference global variables
class VariableResolver
  def initialize(completed_globals)
    @completed_globals = completed_globals
    completed_globals.keys.each do |key|
      define_singleton_method(key.to_sym){ @completed_globals[key] }
    end
    @binding = binding()
  end

  def resolve(variable_declaration)
    # We eval everything except things we set the default on
    # We only set the default if global is false and default isn't nil

    unless @completed_globals.has_key?(variable_declaration.global_name)
      value = variable_declaration.default
    end

    if value.nil?
      value = eval variable_declaration.output_rb, @binding
    end

    return variable_declaration.role_name, value
  end
end