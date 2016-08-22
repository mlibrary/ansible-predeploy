require "yaml"
require_relative "./requirements"
require_relative "./variable_declaration"

class RequirementsPrinter
  def initialize(requirements)
    @requirements = requirements
  end

  # {
  #   global_name: {foo_role: foo_default, bar_role: bar_default}
  #   global_name: {}
  # }
  def requirements_list
    list = {}
    @requirements.globals_declarations
      .select{|k,_| k && k != ""}
      .each do |pair|
      list[pair[0]] = pair[1]
        .map{|i| [i.tag, i.default] }
        .to_h
    end
    return list
  end


  def to_yaml
    list = requirements_list
      .map{|i| [i[0], defaults_string(hash_to_defaults_list(i[1])) ] }
      .to_h
    YAML.dump list
  end

  private

  # Converts {foo_role: foo_default, bar_role: bar_default}
  # to foo_role=foo_default, bar_role=bar_default
  def hash_to_defaults_list(h)
    h.select{|_,v| v && v != "" }
      .collect{|i| [i[0].to_s, i[1].to_s] }
      .map{|i| i.join("=")}
  end

  def defaults_string(list)
    return nil if list.empty?
    "defaults: #{list.join(" ")}"
  end

end