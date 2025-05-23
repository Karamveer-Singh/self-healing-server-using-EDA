
FROM registry.access.redhat.com/ubi9-minimal
RUN microdnf install java-17 python3 gcc python3-devel -y && microdnf clean all && python -m ensurepip --upgrade && pip3 install ansible ansible-rulebook asyncio aiokafka aiohttp aiosignal
ENV JAVA_HOME="/usr/lib/jvm/jre-17"
RUN mkdir /eda-ansible
RUN ansible-galaxy collection install ansible.eda
WORKDIR /eda-ansible
COPY . /eda-ansible
CMD ansible-rulebook -i inventory --rulebook ansible-rulebook.yaml  --verbose
