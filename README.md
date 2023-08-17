# NetworkInterface

A simple Ruby wrapper for accessing network interface information

## Installation

Add this line to your application's Gemfile:

    gem 'network_interface'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install network_interface

## Usage

```ruby
require 'network_interface'

puts NetworkInterface.interfaces
puts NetworkInterface.addresses('eth0')
```

## Development

Compiling:

```
bundle install
bundle exec rake clean
bundle exec rake compile
```

Running the test suite, requires `ifconfig`/`ipconfig` to be installed:

```
bundle exec rspec
```

To debug with GDB:

1. Optional: Explicitly add `asm("int3");` into the C code that you wish to have a breakpoint for:

```c
VALUE rb_cNetworkInterface;
void
Init_network_interface_ext()
{
    asm("int3");

    // ...
}
```

2. Compile and start GDB:

```shell
bundle exec rake compile
gdb run --args ruby -e '$LOAD_PATH.unshift(File.join(Dir.pwd, "lib")); require("network_interface"); puts NetworkInterface.interfaces'
```

3. Add a runtime breakpoint:

```shell
(gdb) add-symbol-file ./lib/network_interface_ext.so
Reading symbols from ./lib/network_interface_ext.so...

(gdb) break Init_network_interface_ext
Breakpoint 1 at 0x1850: file ../../../../ext/network_interface_ext/netifaces.c, line 825.

(gdb) run
Starting program: /usr/bin/ruby -e \$LOAD_PATH.unshift\(File.join\(Dir.pwd,\ \"lib\"\)\)\;\ require\(\"network_interface\"\)\;\ puts\ NetworkInterface.interfaces
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".

Breakpoint 1.2, Init_network_interface_ext () at ../../../../ext/network_interface_ext/netifaces.c:825
825             rb_cNetworkInterface = rb_define_module("NetworkInterface");
(gdb)
```

To use a development build of this gem in another project, add this to the target project's `Gemfile`:

```
gem 'network_interface', path: '../network_interface'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
