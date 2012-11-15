__OVERVIEW__


| Project         | IChannel    
|:----------------|:--------------------------------------------------
| Homepage        | https://github.com/robgleeson/ichannel
| Documentation   | http://rubydoc.info/gems/ichannel/frames 
| CI              | [![Build Status](https://travis-ci.org/robgleeson/ichannel.png)](https://travis-ci.org/robgleeson/ichannel)
| Author          | Robert Gleeson             


__DESCRIPTION__

Provides a modern and easy to use interprocess communication(IPC) primitive.
It could be used to transport Ruby objects between Ruby processes running on the 
same machine, and the serialization options are flexible: any serializer that 
implements `#dump` & `#load` can be used -- this covers Marshal, YAML, & JSON 
out of the box but not msgpack, although you could wrap msgpack in an interface 
that implements dump & load.


__EXAMPLES__

__1.__

  channel = IChannel.new Marshal
  channel.put 'hello'
  channel.put 'goodbye'
  pid = fork do 
    channel.get # => 'hello'
    channel.get # => 'goodbye'
  end
  Process.wait pid

__REAL WORLD EXAMPLES__
 
 I am using IChannel in a couple of my own personal projects:

 - [IProcess](https://github.com/robgleeson/iprocess)
 - [XPool](https://github.com/robgleeson/xpool)  

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
