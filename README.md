__OVERVIEW__


| Project         | IChannel    
|:----------------|:--------------------------------------------------
| Homepage        | https://github.com/robgleeson/ichannel
| Documentation   | http://rubydoc.info/gems/ichannel/frames 
| CI              | [![Build Status](https://travis-ci.org/robgleeson/ichannel.png)](https://travis-ci.org/robgleeson/ichannel)
| Author          | Robert Gleeson             


__DESCRIPTION__

A modern and easy to use interprocess communication(IPC) primitive.
Ruby objects can be easily transported between a parent process & its 
subprocesses. The serialization options are flexible: any serializer that 
implements `#dump` & `#load` can be used -- this covers Marshal, YAML, & JSON 
out of the box. 

__EXAMPLES__

__1.__

The first example shows off how you'd pass Ruby objects through a channel.
The serializer of choice is `Marshal` but it could just as easily be `JSON` or
`YAML`.

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
