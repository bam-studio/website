The BAM Architecture Studio website (http://bam-studio.com) is powered by [LocomotiveCMS](http://doc.locomotivecms.com/), an opensource CMS platform. LocomotiveCMS provides a back-office application (aka: "engine") for hosting and managing websites. It also provides a development tool called "Wagon", which can pull and push data to and from the engine. The Wagon tool can also act as a lightweight development server. See the [Locomotive project on Github](https://github.com/locomotivecms/engine/tree/v2.5.7) for detailed information.

#### Prerequisites for Using this Project:

You must have the Docker toolchain installed: https://docs.docker.com/docker-for-mac/

# Overview

This project is split into 3 contextual directories: `engine`, `db`, and `wagon`.

## Engine

The LocmotiveCMS Engine is a stateless Rails application that powers the site. The engine serves page requests, handles the restful API, and hosts the back-office where site editors can update the site's content. Locomotive is a unique system in that code deploys are "hot", meaning all site changes are pushed directly to the server via an API and without requiring a restart.

In general, the only time you'll need to modify the Engine code is if you decide to make changes to the Gemfile. Because this engine is [hosted as a Docker image on DockerHub](https://hub.docker.com/r/bamstudio/locomotive), it's unlikely you will ever need to touch it.

(All code related to the engine can be found under [./engine](./engine))

#### Engine Development

Deploying the Engine locally is not necessary for development, but if you wish to do so, you can deploy it with:

```
docker-compose up engine db
```

Then visit http://localhost:3000/locomotive and you will be promted to set up an account.

To deploy a site to the engine, you will need to use Wagon.

## Wagon

Wagon is a command line tool that let's you develop site changes right on your local machine. You can add new content types and templates using any text editor and, thanks to Wagon's built-in web server, you can preview the site with your computer's web browser.

Wagon can also hot-deploy site changes to the Engine using its "push" command. Your changes will immediately be reflected on that site without restarting.

For detailed instructions on how to use Wagon to develop a LocomotiveCMS site, please reference the docs: http://doc.locomotivecms.com/

(The Wagon workspace for the bam-studio site can be found under [./wagon](./wagon))

#### Wagon Development

Before making alterations to the site, you should first "pull" the latest site data from the Engine.

The Engine configuration can be found in [./wagon/config/deploy.yml](./wagon/config/deploy.yml). In order to pull or push to a site you will need access to an api key specified as the env var `BAMSTUDIO_API_KEY`. Your production api key can be found on your account page at http://www.bam-studio.com/locomotive/my_account/edit under the section "Credentials".

Pulling the production site into this project:

```
docker-compose run -e BAMSTUDIO_API_KEY=<api_key> wagon bundle exec wagon pull production
```

## DB


## Usage

#### Prerequisites:

You must have the Docker toolchain installed: https://docs.docker.com/docker-for-mac/

#### To build this image:

```
> make docker
```

#### To deploy this image to localhost:

```
> make localhost
```

This will deploy a running engine locally backed by a mongo database using Docker Compose.

#### To create a release on Docker Hub

```
> BAMSTUDIO_RELEASE=<version> make release
```

This will add a git tag in the form of `<version>-engine<locomotive_cms_gem_version>` and kick off an automated build on Docker Hub: https://hub.docker.com/r/bamstudio/backend/builds/

#### To access the localhost admin page:

Visit http://localhost:3000/locomotive and you will be promted to set up an account.

#### To push website data to your localhost deployment:

LocomotiveCMS uses the [`wagon`](http://doc.locomotivecms.com/get-started/install-wagon) gem to interact with the engine. It can be used to pull and push data to an engine, as well as a development server.

See http://github.com/bam-studio/frontend for more information.