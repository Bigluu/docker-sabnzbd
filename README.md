
### SABNZBd

![Sabnzbd logo](https://raw.githubusercontent.com/HipsterWhale/docker-sabnzbd/master/logo.png)

#### What is it ?
The aim of this Dockerfile is to create a basic image of a completly running and updated sabnzbd under an alpine.

#### How can I use it ?
Simply start the container : 

```
docker run -d \
  -v /configs/sabnzbd:/config \
  -v /mnt/downloads:/downloads \
  --name=sabnzbd -p 8080:8080 bahaika/sabnzbd
```
