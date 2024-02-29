FROM registry.redhat.io/ansible-automation-platform-23/ee-supported-rhel8

LABEL maintainer="Eduardo Troleis" \
	description="Azure execution environment"

RUN microdnf install -y dnf jq \
  && rpm --import https://packages.microsoft.com/keys/microsoft.asc \
	&& dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm \
	&& dnf install -y azure-cli \
	&& ansible-galaxy collection install azure.azcollection \
  && curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
  && chmod +x ./kubectl \
  && mv ./kubectl /usr/local/bin/kubectl
