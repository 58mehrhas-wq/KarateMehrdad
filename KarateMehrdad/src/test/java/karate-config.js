function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'mehrdadkarate1@test.com'
    config.userPassword = 'Test123!'
    // customize
    // e.g. config.foo = 'bar';
  } 
  if (env == 'qa') {
    // customize
    config.userEmail = 'mehrdadkarate2@test.com'
    config.userPassword = 'Test123!'
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers', {Authorization: 'Token ' + accessToken})

  return config;
}