FROM mongo:2.6.12

RUN apt-get update
RUN apt-get install -y nfs-common

EXPOSE 2049

COPY startup.sh /usr/local/bin/

ENV EFS_MOUNT /mnt/efs
CMD startup.sh $EFS_DNS $EFS_MOUNT