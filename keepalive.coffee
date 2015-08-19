http = require 'http'

http.get 'http://thankubot.herokuapp.com'

setTimeout ->
	http.get 'http://thankubot.herokuapp.com'
,300000