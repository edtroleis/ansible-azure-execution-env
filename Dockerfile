FROM registry.redhat.io/ansible-automation-platform-23/ee-supported-rhel8

ENV http_proxy=""
ENV https_proxy=""
ENV HTTP_proxy=""
ENV HTTPS_proxy=""

LABEL maintainer="Eduardo Troleis" \
	description="Ansible execution environment for Azure"

RUN microdnf install -y dnf jq \
  && rpm --import https://packages.microsoft.com/keys/microsoft.asc \
	&& dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm \
	&& dnf install -y azure-cli \
	&& ansible-galaxy collection install azure.azcollection \
  && pip3 install -r ~/.ansible/collections/ansible_collections/azure/azcollection/requirements-azure.txt \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl
