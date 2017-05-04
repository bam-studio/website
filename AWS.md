This file contains Ops information about the BAM Studio site. If all you need to do is web development against the site (ie: HTML changes, or CMS templating updates), then you can safely ignore this readme.

However, if you need to perform scaling operations, swap out load balancers, or otherwise want to change the infrastructure of the site, you will need to understand everything here.

## AWS

The BAM Studio site is deployed using a combination of AWS services, all of which work together as a "hands off" deployment of this project. It was designed to meet the following requirements:

1. Cost effective: Small monthly AWS bills and little to no maintenance overhead.
1. Fault tolerant: Self recovering from server failures or database restarts.
1. Scalable: Autoscaling to meet future traffic demands.
1. Independent of web development: A typical web developer does not need to know about or understand how the infrastructure is maintained in order to work on the site (See the "Wagon" section in the [README.md](./README.md))

You will need to meet the following prerequisites in order to administer the AWS backend:

1. An AWS IAM role with administrative access and login credentials for https://bam-studio.signin.aws.amazon.com/console
1. Knowledge of AWS EC2 Container Service
1. Knowledge of AWS Elastic Load Balancer
1. Knowledge of AWS Elastic File System

#### EC2 Container Service

This is the heart and soul of the deployment. BAM's [Docker](https://hub.docker.com/r/bamstudio/) images for both the web process and database are configured and deployed as ECS tasks on a small cluster.

#### Elastic Load Balancer

An app-level ELB is configured for the ECS task that hosts the site. The DNS name www.bam-studio.com points to this ELB.

#### Elastic File System

The Mongo database that this project depends on is a single process within an ECS task (ie: A Docker container). That means it would normally be vulnerable to data loss if the EC2 host it resides on is terminated or restarted. The avoid such a catastrophe, a replica-set or regular data backup is typically used. This project uses a different strategy: an EFS is mounted to the container to host the database files. We can do this safely because the access patterns on the database do not require high performance. And because EFS is a managed filesystem, we get high availability without process or maintenance overhead.