ARG ACCOUNTID=289509258540
ARG AWSREGION=us-east-1
ARG ECRREPO=amazoncorretto
ARG IMAGEVERSION=latest
ARG CHAMBER_VERSION=2.9.1

FROM segment/chamber:${CHAMBER_VERSION} as CHAMBER
FROM ${ACCOUNTID}.dkr.ecr.${AWSREGION}.amazonaws.com/${ECRREPO}:${IMAGEVERSION}
FROM RedVentures/rv-nifi-test

ADD keto.yml /config/keto.yml

EXPOSE 8080 8443 9088

USER root

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY --from=CHAMBER /chamber /usr/local/bin/chamber

RUN apk add --no-cache openssl