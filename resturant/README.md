# README

The api contains:
1. Users
2. Items
3. Menu
4. Order

It uses Swagger Docs for Api documentation.

Things you may want to cover:

* Ruby version : 2.3.1

* Install and Setup Postgres SQL
This can help http://stackoverflow.com/questions/7975556/how-to-start-postgresql-server-on-mac-os-x

* Dependencies: Run ```bundle install```

* Database creation: Run ```rake db:create``` and ```rake db:migrate```

* Database initialization Run "rake db:seed"
This creates a Admin user with email : "admin@example.com" and password: "admin123"

* To run the test_suite:
```bundle exec rspec spec```
Currently some tests are failing as I am having some difficultly while creating stub for authentication token. If we remove the before action for authentication and authorization from the controllers, the test would pass.


* To run the application:
```rails s```

In the browser navigate to "localhost:3000/api", this will take you to Swagger API documentation, where the api endpoints can be visualized and tested by making a request.

Additionally api also supports nested urls which are not shown in the Swagger API documentation but they can be used by curl. For example to get all the orders of user with user id 10, the url would be "localhost:3000/users/1/orders" but it has to be called using curl with the "auth\_token" in header.

Also in the Swagger API calls the auth\_token has to be provided. The auth\_token can be found after calling the user/authenticate end point from the Swagger API portal.
Default credentials can be used:
username: admin@example.com
password: admin123


I have used JSON Web Token (JWT) for the API such that now the token doesn't need to be stored in the database and it makes the authentication and other requests which need authentication stateless, as DB doesn't need to maintain session tokens, the JWT algorithm can encode/decode on the go.
