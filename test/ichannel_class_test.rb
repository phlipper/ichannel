require_relative 'setup'
class IChannelTest < Test::Unit::TestCase
  def setup
    @channel = IChannel.new Marshal
  end

  def teardown
    @channel.close
  end

  def test_put_and_get 
    pid = fork do
      @channel.put %w(a b c)
    end
    Process.wait pid
    assert_equal %w(a b c), @channel.get
  end

  def test_queued_messages
    pid = fork do 
      @channel.put %w(a)
      @channel.put %w(b)
    end
    Process.wait pid
    assert_equal %w(a), @channel.get
    assert_equal %w(b), @channel.get
  end
end
