# Sample to demonstrate testing code against different database images

Using docker images we can test code against different database images held in a registry. For this demonstration local images are used instead.

## Build first database images

```
docker build -t db:master database_master/.
docker build -t db:feature database_feature/.
```

## Check docker-compose.yml

```
    database:
      image: db:master

    website:
      build: ../website_master
```

## Test system:

- Start containers `docker-compose up`
    - logs spool to current window
- Get data back `curl localhost:3000` 
    - Two customer rows should return

## Change data volume

- In `docker-compose.yml` change data per gender value from 1 to 5000.
```
    database:
      image: db:master
      environment:
        - DATA=5000
```
- Stop containers Control-C `docker-compose up`
- Delete database container `docker-compose rm -f database`
- Start containers `docker-compose up`
- Get data back `curl localhost:3000` 
    - 10,000 customer rows should return

## Change code branch

- Stop containers Control-C `docker-compose up`
- Delete website container `docker-compose rm -f website`
- In `docker-compose.yml` change `website_master` to `website_feature`
```
    website:
      build: ../website_feature
      volumes:
        - ../website_feature:/src
```
- Start containers `docker-compose up`
- Get data back `curl localhost:3000` 
    - Should get "Internal server error" because database is out of sync
- Stop containers Control-C `docker-compose up`
- Delete database container `docker-compose rm -f database`
- In `docker-compose.yml` change `db:master` to `db:feature`
```
    database:
      image: db:feature
```
- Start containers `docker-compose up`
- Get data back `curl localhost:3000` 
    - 10,000 customer rows should return


