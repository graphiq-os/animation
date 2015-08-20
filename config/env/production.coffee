module.exports =
  app:
    title: 'GraphQ'
    url: 'https://52.11.211.11'
  
  port: process.env.PORT || 80

  log:
    format: 'combined'
    options:
      stream: 'access.log'