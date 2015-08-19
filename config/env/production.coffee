module.exports =
  app:
    title: 'GraphQ'
    url: 'https://thankubot.herokuapp.com'
  
  port: process.env.PORT || 80

  log:
    format: 'combined'
    options:
      stream: 'access.log'