
```console
docker -d \
  -p 8211:8211/udp \
  --restart unless-stopped \
  -v palworld-data:/home/palworld/Steam/steamapps/common \
  --name palworld \
  github.io/itay-grudev/palworld:latest
```
