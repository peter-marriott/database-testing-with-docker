# Sample to demonstrate testing code against different database images

Using docker images we can test code against different database images held in a registry. For this demonstration local images are used instead.

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
