
require_relative "./variable_declaration"
require_relative "./requirements"
require_relative "./requirements_printer"
require_relative "./variable_resolver"
require 'yaml'


# Import a file.
# Returns an array of the form
# [filename.basename, file contents as hash]
# @param [String] filename
# @return String, Hash
def import_file(filename)
  [File.basename(filename).sub(".yml", ""), YAML.load(File.read(filename.to_s))]
end


# Import all of the files in a directory.
# Returns array of filename.basename, contents
# hash pairs.
# @param [String] dir
# @return Array<String,Hash>
def import_files(dir)
  Dir.glob(dir.to_s).map {|file| import_file(file)}
end


# Build requirements from a set of configs
def build_requirements(config_dir, excluded_roles)
  raw_configs = import_files(File.join(config_dir, "*.yml"))
  Requirements.new(raw_configs, excluded_roles)
end


# Print formatted requirements
def requirements_yaml(built_requirements)
  RequirementsPrinter.new(built_requirements).to_yaml
end


# Build ansible setup vars
def build_ansible_setup(requirements, complete_var_file)
  completed_vars = YAML.load(File.read(complete_var_file.to_s))
  resolver = VariableResolver.new completed_vars
  requirements.declarations
    .map{|d| resolver.resolve(d) }
    .to_h
end


# Print formatted ansible vars
def ansible_setup_yaml(built_setup)
  YAML.dump(built_setup)
end










