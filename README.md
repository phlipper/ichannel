__OVERVIEW__


| Project         | IChannel    
|:----------------|:--------------------------------------------------
| Homepage        | https://github.com/robgleeson/ichannel
| Documentation   | http://rubydoc.info/gems/ichannel/frames 
| CI              | [![Build Status](https://travis-ci.org/robgleeson/ichannel.png)](https://travis-ci.org/robgleeson/ichannel)
| Author          | Robert Gleeson             


__DESCRIPTION__

A modern, flexible & easy to use interprocess communication(IPC) primitive. The 
basic premise is that you can "put" and "get" Ruby objects to/from a channel. 
This works across any Ruby process & its subprocesses, though, which is why it 
can be useful. You could describe putting and getting objects to/from the channel
as message passing but the message could potentially be any Ruby object, 
although I think sending small messages(as a Hash) works very well for most 
scenarios. You have the potential to serialize any object that `Marshal` can 
dump+load, though.

__SERIALIZERS__

To send Ruby objects between processes they have to be serialized, but on the
bright side the number of serializers to choose from is vast. Marshal, JSON, & 
YAML are supported out of the box to name a few but adding support for other 
serializers is a trivial amount of work.

For example, here is a MessagePack serializer you could use:

```ruby
require 'ichannel'
require 'msgpack'
serializer = Class.new do
  def self.dump(msg)
    MessagePack.pack msg
  end

  def self.load(msg)
    MessagePack.unpack msg
  end
end
channel = IChannel.new serializer
```

As you can see above as long as the serializer responds to `.dump` & `.load` it 
can be passed as a serializer to IChannel.

__EXAMPLES__

__1.__

The first example shows off how you'd pass Ruby objects through a channel.
The serializer of choice is `Marshal` but it could just as easily be `JSON` or
`YAML`.

```ruby
channel = IChannel.new Marshal
channel.put 'hello'
channel.put 'goodbye'
pid = fork do 
  channel.get # => 'hello'
  channel.get # => 'goodbye'
end
Process.wait pid
```

__REAL WORLD EXAMPLES__
 
 I am using IChannel in a couple of my own personal projects:

 - [IProcess](https://github.com/robgleeson/iprocess)  
    Provides a number of abstractions on top of spawning subprocesses and 
    interprocess communication. IChannel was born inside IProcess but later 
    extracted into its own project when I realised it could be useful on its
    own.

 - [XPool](https://github.com/robgleeson/xpool)  
    A UNIX(X) Process Pool.

__PLATFORM SUPPORT__

_supported_

  * CRuby (1.9+)

_unsupported_
  
  * CRuby 1.8
  * MacRuby
  * JRuby
  * Rubinius (support for Rubinius will come sometime in the future).

__INSTALL__

    $ gem install ichannel

__LICENSE__

MIT. See LICENSE.txt.
