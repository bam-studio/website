## Docker Images

This project also uses a Makefile to manage docker images for the website and database. The tags for each image is composed of the LocomotiveCMS engine and Mongo versions plus a release number specified by you.

There are already working images hosted at https://hub.docker.com/r/bamstudio/, but if you _must_ push new versions, you can use the following instructions to build images using the proper tag conventions:

#### To build image:

```
> BAMSTUDIO_RELEASE=<version> make
```

You can also use `dryrun` to see what _would_ occur before you make:

```
> BAMSTUDIO_RELEASE=1.0.1 make dryrun
```

Outputs:

```
would> docker build -t bamstudio/web ./engine
would> docker tag bamstudio/web bamstudio/web:1.0.1-locomotivecms2.5.7
would> docker build -t bamstudio/db ./db
would> docker tag bamstudio/db bamstudio/db:1.0.1-mongo2.6.12
```