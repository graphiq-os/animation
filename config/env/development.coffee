module.exports =
  app:
    title: 'GraphQ'
    url: 'http://192.168.1.129:3000'
  
  port: process.env.PORT || 3000

  log:
    format: 'combined'
    options:
      stream: 'access.log'