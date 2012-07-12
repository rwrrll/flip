# Flip

## A motherfucking split flap display in your motherfucking browser.

### What?

Click this screen grab to view a 56-second demo:

[![Video Screen Grab](http://b.vimeocdn.com/ts/317/513/317513725_640.jpg)](https://vimeo.com/45645328)

Flip is a live streaming Solari Board powered by Sinatra, WebSockets, CSS3 animations and a little bit of hash. It doesn't use any images at all.

### Install it.

~~~ sh
$ git clone
$ cd flip
$ bundle install
~~~

### Use it.

~~~ sh
$ ruby flip.rb
~~~

Hit up `http://localhost:3000/` to view the motherfucker.

Post `message=[whatever]` to `http://localhost:3000/` to update the motherfucker.	
### Current Limitations.

If you want to use it in anything other than WebKit, you'll need to make that work. And I used TypeKit, so the fonts won't work outside of localhost.