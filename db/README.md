#### DB

The LocmotiveCMS Engine is backed by a Mongo database that stores data on a network file system, specifically AWS's Elastic File Service. No, this is not typically a recommended way to deploy a Mongo database, but for the limited throughput and size of BAM's website, it is well suited. The primary benefit of this design is that EFS is a managed file system that is tolerant to server failures and restarts. Ie: We can deploy a single-instance database without replica sets or backups and be confident that we will not lose any data.

This project provides a docker image for 

#### To build this image:

```
> make docker
```

#### To create a release on Docker Hub

```
> BAMSTUDIO_RELEASE=<version> make release
```

This will add a git tag in the form of `<version>-mongo<mongo_version>` and kick off an automated build on Docker Hub: https://hub.docker.com/r/bamstudio/mongo/builds/