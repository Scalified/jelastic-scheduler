FROM scalified/alpine-cron:latest

ENV JELASTIC_HOME /root/jelastic
ENV JELASTIC_SCRIPTS_DIR /root/.scripts
ENV CRONTABS_DIR /var/spool/cron/crontabs
ENV JELASTIC_CONFIG_DIR /root/.config/jelastic
ENV JELASTIC_CLI_URL ftp://ftp.jelastic.com/pub/cli/jelastic-cli-installer.sh
ENV ROOT_CRONTABS_FILE $CRONTABS_DIR/root
ENV CRON_LOG_DIR /var/log/crond

ARG JELASTIC_LOGIN
ARG JELASTIC_PASSWORD
ARG ENVIRONMENTS
ENV JELASTIC_LOGIN ${JELASTIC_LOGIN}
ENV JELASTIC_PASSWORD ${JELASTIC_LOGIN}
ENV ENVIRONMENTS ${ENVIRONMENTS}

RUN apk add --update --no-cache curl \
	openjdk8
	     
RUN curl -s $JELASTIC_CLI_URL  | sh

RUN mkdir -p $JELASTIC_SCRIPTS_DIR $CRON_LOG_DIR \	
	$JELASTIC_CONFIG_DIR

COPY scripts/environments.sh $JELASTIC_SCRIPTS_DIR

RUN dos2unix $JELASTIC_SCRIPTS_DIR/environments.sh

RUN chmod u+x $JELASTIC_SCRIPTS_DIR/environments.sh \	
	&& echo "TZ=UTC" >> $ROOT_CRONTABS_FILE \
	&& echo "00      20      *       *       1-5     $JELASTIC_SCRIPTS_DIR/environments.sh stop >> $CRON_LOG_DIR/environments.log" >> $ROOT_CRONTABS_FILE \
	&& echo "00      07      *       *       1-5     $JELASTIC_SCRIPTS_DIR/environments.sh start >> $CRON_LOG_DIR/environments.log" >> $ROOT_CRONTABS_FILE

VOLUME $JELASTIC_SCRIPTS_DIR
VOLUME $JELASTIC_HOME
VOLUME $CRONTABS_DIR
VOLUME $JELASTIC_CONFIG_DIR