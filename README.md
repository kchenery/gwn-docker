# Grandstream GWN Manager

This is a version of [Grandstream's GWN Manager](http://www.grandstream.com/products/networking-solutions/wi-fi-management/product/gwn-manager) running in docker.  The base OS is Centos 7 as this is one of the supported operating systems as per the documentation

Configuration of GWN Manager has been performed so that the web interface is listening on `http://localhost:8000` with the gateway listening on port `10014`.

All the required services are defined in the image including:

* nginx
* mysql
* redis

According to the Grandstream documentation you should use their versions of these services.

Grandstream documentation: [`https://documentation.grandstream.com/knowledge-base/gwn-management-platforms-user-guide/`](https://documentation.grandstream.com/knowledge-base/gwn-management-platforms-user-guide/)

## Building the image

1. Clone the repository
2. run `docker build . -t gwn`

This will tag the image with `gwn`

## Running the image

1. Build the image
2. Run: `docker run -d -p 8000:8000/tcp -p 10014:10014/tcp --name gwn gwn`<br/>**Note:** it takes a little while to start up the web client.
3. Connect with: [`http://localhost:8000`](http://localhost:8000)
4. Upon first connection you will be asked to configure the admin account - follow the on screen prompts

This will run a container named `gwn`.

## Modifying the internal configuration

1. Connect to the container with: `docker exec -it gwn /bin/bash`
2. Run: `cd /gwn`
3. Run: `./gwn config`

## Docker compose

You can do the building and running of the container with `docker compose up -d` too.
