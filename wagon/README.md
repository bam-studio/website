The BAM Architecture Studio website is built on top of LocomotiveCMS, an opensource CMS platform. LocomotiveCMS provides an "engine" for hosting and managing a website as well as a development tool called "Wagon". Locomotive is backed by a Mongo database.

_This project is a Wagon project and it is all you need to make web-development changes to bam-studio.com_

#### Engine

The LocmotiveCMS Engine is a Rails engine that's installed into a Rails application. This engine runs in production, dealing with page requests, handling the restful API, and running the back-office where site editors can update the site's content.

In general, the only time you'll spend with Engine is at the beginning when you're setting up LocomotiveCMS. You'll have to install the gem, do some configuration, and get Rails running. But after that, you're pretty much done working with Engine.

A specially modified engine that powers bam-studio.com can be found at https://github.com/bam-studio/backend

#### Wagon

Wagon is a command line tool that let's you develop for LocomotiveCMS right on your local machine.

With Wagon, you can generate the scaffolding for a new LocomotiveCMS site and start adding the content types and templates you need using any text editor. And thanks to Wagon's built-in web server, you can preview the site with your computer's web browser.

Wagon can also deploy sites to any LocomotiveCMS Engine using the wagon push command. Your changes will immediately be reflected on that site without restarting or making any changes to the Rails app.


## Usage

#### Prerequisites:

Just ruby: `bundle install`

#### To pull the site's data:

Each environment that this Wagon project has access to is configured at [config/deploy.yml](config/deploy.yml). The configuration depends on an environment variable called `BAMSTUDIO_API_KEY`.

You must have access to an API key in order to pull from a LocomotiveCMS site. Your API key can be found on your account page under "Credentials": http://bam-studio.com/locomotive/my_account/edit

To pull from production:

```
> BAMSTUDIO_API_KEY=<api_key> bundle exec wagon pull production
```

This may take several minutes, and will export all assets, scripts, and CMS data into this project.

#### To make changes to the site:

You can make changes to webpages and templates that Locomotive uses to render the site here. See LocomotiveCMS's comprehensive documentation for editing templates and content types: http://doc.locomotivecms.com/references/liquid-language

#### To preview your changes:

```
> bundle exec wagon serve
```

And visit: http://localhost:3333

#### To deploy your change to the production engine:

Once you're satisfied with your changes, you can push them directly to the backend:

```
> BAMSTUDIO_API_KEY=<api_key> bundle exec wagon push production
```

More LocomotiveCMS docs on deployment: http://doc.locomotivecms.com/get-started/deployment
