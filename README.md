# Sample to show using docker to test different versions od a database

```
cd database_branch1
docker build -t db:v1 .
docker images
```

`cd ..`

```
cd database_branch2
docker build -t db:v1 .
docker images
```
