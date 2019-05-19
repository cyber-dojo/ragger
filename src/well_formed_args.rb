require_relative 'base58'
require_relative 'client_error'
require_relative 'well_formed_image_name'
require 'json'

# Checks for arguments synactic correctness

module WellFormedArgs

  def well_formed_args(s)
    @args = JSON.parse(s)
    if @args.nil? || !@args.is_a?(Hash)
      malformed('json')
    end
  rescue
    malformed('json')
  end

  # - - - - - - - - - - - - - - - -

  def image_name
    name = __method__.to_s
    arg = @args[name]
    unless well_formed_image_name?(arg)
      malformed(name)
    end
    arg
  end

  # - - - - - - - - - - - - - - - -

  def id
    name = __method__.to_s
    arg = @args[name]
    unless well_formed_id?(arg)
      malformed(name)
    end
    arg
  end

  # - - - - - - - - - - - - - - - -

  def stdout
    name = __method__.to_s
    arg = @args[name]
    unless arg.is_a?(String)
      malformed(name)
    end
    arg
  end

  # - - - - - - - - - - - - - - - -

  def stderr
    name = __method__.to_s
    arg = @args[name]
    unless arg.is_a?(String)
      malformed(name)
    end
    arg
  end

  # - - - - - - - - - - - - - - - -

  def status
    name = __method__.to_s
    arg = @args[name]
    unless arg.is_a?(String)
      malformed(name)
    end
    arg
  end

  private # = = = = = = = = = = = =

  include WellFormedImageName

  def well_formed_id?(arg)
    Base58.string?(arg) && arg.size === 6
  end

  def malformed(arg_name)
    raise ClientError, "#{arg_name}:malformed"
  end

end
