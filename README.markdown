## pdf-calendar
A ruby script that generates PDF calendars using Apache FOP.
 
### Requirements
* Ruby, Apache FOP installation

### Quick Install
1. Move GitNub.app to /Applications
2. Move (or symlink) nub shell file to /usr/local/bin

http://xmlgraphics.apache.org/fop/0.95/running.html

### How to Use
In your shell, move to a git directory and invoke `nub`.  You always use this 
helper to invoke the application, otherwise you get nothing.

		$Caged@caged:~/dev/git/gitnub% nub

		
### Building from Source
1. Run `git submodule init` & `git submodule update` in the root directory.
2. Run `rake build` or open GitNub.xcodeproj in Xcode - press Build
3. Run `rake install` to move GitNub.app to /Applications and copy nub to /usr/local/bin.
   
### Major Contributors
* Matthias Luedtke - Maintainer
