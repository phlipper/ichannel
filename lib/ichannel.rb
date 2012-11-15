require 'socket'
class IChannel
  #
  # @param [#dump,#load}] serializer
  #   Any object that implements dump, & load.
  #   
  def initialize(serializer) 
    @reader, @writer = UNIXSocket.pair Socket::SOCK_DGRAM
    @serializer = serializer 
  end

  #
  # Close the channel.
  #
  # @raise [IOError]
  #   When the channel is closed already.
  #
  # @return [Boolean]
  #   Returns true(-ish) when the channel is closed successfully.
  #  
  def close
    [@reader.close, @writer.close]
  end

  #
  # @return [Boolean]
  #   Returns true if the channel is closed.
  #
  def closed?
    @reader.closed? && @writer.closed?
  end

  #
  # @return [Boolean]
  #   Returns true if the channel is open.
  #
  def open?
    !closed?
  end

  #
  # Add an object to the channel.
  #
  # @param [Object] object
  #   An object to add to the channel.
  #
  def write(object)
    _, writable, _ = IO.select [], [@writer], [], 0.1
    if writable
      @writer.send @serializer.dump(object), 0
    end
  end
  alias_method :put, :write

  #
  # Receive a object from the channel.
  #
  # @return [Object]
  #   The object added to the channel.
  #
  def recv
    readable, _ = IO.select [@reader], [], [], 0.1
    if readable
      msg, _ = @reader.recvmsg
      @serializer.load msg
    end
  end
  alias_method :get, :recv
end
