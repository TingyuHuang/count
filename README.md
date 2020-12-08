# count-files

count-files is a simple web app for counting filename pattern of

```
xxxxxxxx-[pattern].tst
```

## How to build it

```
docker build -t count-files .
```

## Install from Dockerhub

```
docker pull tingyuhuang/count-files
docker run -p 8080:80 -t tingyuhuang/count-files
```

Then, visit `http://localhost:8080`
