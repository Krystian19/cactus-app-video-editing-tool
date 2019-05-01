# Video Editor

Video editor docs

## How to setup

+ Build the image
```sh
docker build --no-cache -t golang/env .
```

+ Run the container
```sh
docker run --name golang -v $(pwd):/go/src/github.com/videoeditor --detach golang/env
```

+ Enter the container
```sh
docker exec -ti golang /bin/sh
```