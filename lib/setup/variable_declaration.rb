class VariableDeclaration

  class << self
    def from_complex_string(tag, key, value)
      pairs = value.split(" ")
        .map{|i| i.split("=")}
        .map{|i| [i.at(0), i.at(1) || nil ]}
      from_hash(tag, key, pairs.to_h)
    end


    def from_hash(tag, key, value)
      VariableDeclaration.new(tag, key, value["global"], value["default"], value["output"])
    end


    def from_anything(tag, key, value)
      case value
      when String
        if value.include?("=")
          from_complex_string(tag, key, value)
        else
          VariableDeclaration.new(tag, key, value, nil, nil)
        end
      when Array
        VariableDeclaration.new(tag, key, *(value.fill(nil, value.length, 4 - value.length)))
      when Hash
        from_hash(tag, key, value)
      else
        raise ArgumentError, "did not understand type of value"
      end
    end

  end


  def initialize(tag, role_name, global_name, default, output_rb)
    @tag = tag
    @role_name = role_name
    @global_name = global_name
    @default = default
    @output_rb = output_rb || @global_name
  end
  attr_reader :tag, :role_name, :global_name, :default, :output_rb

  def eql?(rhs)
    role_name == rhs.role_name
  end

  def hash
    role_name
  end

  def has_default?
    default != nil
  end




end