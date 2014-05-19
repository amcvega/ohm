require 'connection_pool'

module Ohm
  class Pool
    def initialize(opts = {size: 5, timeout: 5}, &block)
      @pool = ConnectionPool.new(opts, &block)
    end

    def call(*args)
      @pool.with{|r| r.call(*args)}
    end

    def queue(*args)
      @pool.with{|r| r.queue(*args)}
    end

    def commit
      @pool.with{|r| r.commit }
    end

    def timeout
      @pool.with{|r| r.timeout }
    end

    def synchronize(&block)
      @pool.with(&block) # {|r| r.timeout }
    end
  end
end
