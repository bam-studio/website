The BAM Architecture Studio website (http://bam-studio.com) is powered by [LocomotiveCMS](http://doc.locomotivecms.com/), an opensource CMS platform. LocomotiveCMS provides a back-office application (aka: "engine") for hosting and managing websites. It also provides a development tool called "Wagon", which can pull and push data to and from the engine. The Wagon tool can also act as a lightweight development server. See the [Locomotive project on Github](https://github.com/locomotivecms/engine/tree/v2.5.7) for detailed information.

#### Prerequisites for Development:

1. You are a collaborator to this github project.
1. Docker toolchain: https://docs.docker.com/docker-for-mac/

#### Prerequisites for Deployment:

1. Admin access to http://www.bam-studio.com/locomotive
1. An api key, found on your account page at http://www.bam-studio.com/locomotive/my_account/edit under the section "Credentials"

#### Prerequisites for System Administration:

1. AWS IAM role with administrative access and login credentials for https://bam-studio.signin.aws.amazon.com/console
1. A Docker Hub account with membership to the [bamstudio](https://hub.docker.com/r/bamstudio) organization.

See [DOCKER.md](./DOCKER.md) and [AWS.md](./AWS.md) for more sysadmin information.

## Overview

This project is split into 3 contextual directories: `engine`, `db`, and `wagon`.

#### Engine

The LocmotiveCMS Engine is a stateless Rails application that powers the site. The engine serves page requests, handles the restful API, and hosts the back-office where site editors can update the site's content. Locomotive is a unique system in that code deploys are "hot", meaning all site changes are pushed directly to the server via an API and without requiring a restart.

In general, the only time you'll need to modify the Engine code is if you decide to make changes to the Gemfile. Because this engine is [hosted as a Docker image on DockerHub](https://hub.docker.com/r/bamstudio/locomotive), it's unlikely you will ever need to touch it.

(All code related to the engine can be found under [./engine](./engine))

#### Wagon

Wagon is a command line tool that let's you develop site changes right on your local machine. You can add new content types and templates using any text editor and, thanks to Wagon's built-in web server, you can preview the site with your computer's web browser.

Wagon can also hot-deploy site changes to the Engine using its "push" command. Your changes will immediately be reflected on that site without restarting.

For detailed instructions on how to use Wagon to develop a LocomotiveCMS site, please reference the docs: http://doc.locomotivecms.com/

(The Wagon workspace for the bam-studio site can be found under [./wagon](./wagon))

#### DB

BAM's LocmotiveCMS Engine is backed by a Mongo database that stores data on a network file system (AWS's Elastic File Service). 

No, this is not typically a recommended approach for deploying a database, but for the limited throughput and size of BAM's website it is well suited. The primary benefit of this design is that EFS is a managed file system that is tolerant to server failures and restarts. In other words, we can deploy a single-instance database without replica sets or backups and be confident that we will not lose any data.

## Development

#### Localhost Engine

Deploying the Engine locally is not necessary for development, but if you wish to do so, you can deploy it with:

```
docker-compose up engine db
```

Then visit http://localhost:3000/locomotive and you will be promted to set up an account.

To deploy a site to the engine, you will need to use Wagon.


#### Web Development with Wagon

*Note: Before making alterations to the site, you should first "pull" production site data from the Engine.*

The Engine configuration can be found in [./wagon/config/deploy.yml](./wagon/config/deploy.yml). In order to pull or push a site you will need access to an api key specified as the env var `BAMSTUDIO_API_KEY`. Your production api key can be found on your account page at http://www.bam-studio.com/locomotive/my_account/edit under the section "Credentials".

Pulling the production site into this project:

```
docker-compose run -e BAMSTUDIO_API_KEY=<api_key> wagon bundle exec wagon pull production
```

This will take some time to pull down all assets (fonts, js, css, html, etc.) and CMS data, essentially making an offline copy of the database.

You can now serve the site locally with:

```
docker-compose up wagon
```

And visit http://localhost:3333 to see a fully functioning version of the site.

You can now make changes to webpages and templates that Locomotive uses to render the site. See LocomotiveCMS's comprehensive documentation for editing templates and content types: http://doc.locomotivecms.com/references/liquid-language.

#### Deploying to Production

Once you are satisfied with your changes you can deploy them to the production Engine:

```
docker-compose run -e BAMSTUDIO_API_KEY=<api_key> wagon bundle exec wagon push production
```

More LocomotiveCMS docs on deployment: http://doc.locomotivecms.com/get-started/deployment
