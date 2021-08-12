FROM alpine:3

LABEL maintainer="Julien Künzi <julien.kuenzi@22trustventure.com>"

ENV YETI_VERSION 6.2.0

# FIXME     For some reason the sha1 checksum file ends with \r\n,
# FIXME     and the sha1sum check fails because of this.
# FIXME     So I `dos2unix` it before doing the check.,

RUN set -eux -o pipefail; \
    cd /; \
    TO_INSTALL="shadow"; \
    TO_UNINSTALL="${TO_INSTALL}"; \
    PACKAGE_DOWNLOAD_URL="https://github.com/YetiForceCompany/YetiForceCRM/releases/download/${YETI_VERSION}/YetiForceCRM-${YETI_VERSION}-complete.zip"; \
    CHECKSUM_DOWNLOAD_URL="https://github.com/YetiForceCompany/YetiForceCRM/releases/download/${YETI_VERSION}/YetiForceCRM-${YETI_VERSION}-complete.sha"; \
    apk -U upgrade; \
    apk add ${TO_INSTALL}; \
    groupadd -g 31415 abc; \
    useradd -l -s /bin/false -g abc -u 31415 -M -d /non-existent abc; \
    mkdir /app; \
    chown abc:abc /app; \
    chmod 755 /app; \
    wget -O /YetiForceCRM-${YETI_VERSION}-complete.zip ${PACKAGE_DOWNLOAD_URL}; \
    wget -O /YetiForceCRM-${YETI_VERSION}-complete.zip.sha1 ${CHECKSUM_DOWNLOAD_URL}; \
    dos2unix /YetiForceCRM-${YETI_VERSION}-complete.zip.sha1; \
    sha1sum -c YetiForceCRM-${YETI_VERSION}-complete.zip.sha1; \
    mv /YetiForceCRM-${YETI_VERSION}-complete.zip /yetiforce-from-github-complete.zip; \
    mv /YetiForceCRM-${YETI_VERSION}-complete.zip.sha1 /yetiforce-from-github-complete.zip.sha1; \
    echo "YetiForce ${YETI_VERSION} from github" >/yeti-version; \
    echo ${PACKAGE_DOWNLOAD_URL} >>/yeti-version; \
    echo ${CHECKSUM_DOWNLOAD_URL} >>/yeti-version; \
    apk del ${TO_UNINSTALL};


COPY --chown=abc:abc entrypoint.sh /entrypoint.sh

VOLUME ["/app"]

USER abc

ENTRYPOINT ["/entrypoint.sh"]

