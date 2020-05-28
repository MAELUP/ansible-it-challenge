FROM centos:7
RUN yum install -y epel-release && \
    yum install -y ansible && \
    yum update -y
    
RUN mkdir -p /tmp/ansible-ws && \
	chmod -R g+w /tmp/ansible-ws && chgrp -R root /tmp/ansible-ws && \
	chmod g+w /etc/passwd

COPY ./ansible /tmp/ansible-ws/

WORKDIR /tmp/ansible-ws

CMD ["ansible-playbook", "/tmp/ansible-ws/install.yml"]