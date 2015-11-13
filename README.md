![Sabnzbd logo](http://sabnzbd.org/resources/landing/sabnzbd_logo.png)

# Lightnzbd
Dockerfile to create a light sabnzbd image.

## What is it ?
The aim of this Dockerfile is to create a lightweight image of a completly running and updated sabnzbd.

## Is it really light ?
Not yet really, still a work in progress...

## How can I use it ?
Simply start the container : 
`docker run -d --name=sabnzbd -p 8080:8080 -v /configs/sabnzbd:/config -v /mnt/downloads:/downloads bahaika/lightnzbd`
