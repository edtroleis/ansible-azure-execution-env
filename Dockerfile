FROM registry.redhat.io/ansible-automation-platform-23/ee-supported-rhel8

LABEL maintainer="Eduardo Troleis" \
	description="Azure execution environment"

RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc

RUN microdnf install -y dnf \
	&& dnf install -y https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm \
	&& dnf install -y azure-cli \
	&& ansible-galaxy collection install azure.azcollection
