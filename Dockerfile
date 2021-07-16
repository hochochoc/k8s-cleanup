FROM alpine:3.2

ENV KUBE_VERSION 1.7.8

RUN apk add --update bash curl coreutils \
    && rm -rf /var/cache/apk/*

RUN cd /usr/local/bin \
    && curl -O https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl \
    && chmod 755 /usr/local/bin/kubectl

COPY k8s-gitflow-clean.sh /bin/
RUN chmod +x /bin/k8s-gitflow-clean.sh

ENV NAMESPACE gitflow
ENV DAYS 2

CMD ["bash", "/bin/k8s-gitflow-clean.sh"]
