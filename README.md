# my_workspace
My workspace based on docker

## build
```
sudo docker build --network host -t my_workspace:latest .
```

## Run
```
sudo docker run -it --rm -v <mount absolute path>:/workspace my_workspace
```
