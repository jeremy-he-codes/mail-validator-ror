class BaseService
  def self.call(*args, &block)
    new(*args, &block).call
  end

  def initialize(*_args)
    raise NotImplementedError if instance_of? BaseService
  end
end
