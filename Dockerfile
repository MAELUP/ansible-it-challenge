FROM centos:7
RUN yum install -y epel-release && \
    yum install -y ansible sudo rsync openssh-clients sshpass glibc-langpack-en && \
    yum update -y
 
RUN mkdir -p /tmp/ansible-ws && \
	chmod -R g+w /tmp/ansible-ws && chgrp -R root /tmp/ansible-ws && \
	chmod g+w /etc/passwd

COPY ./ansible /tmp/ansible-ws/

WORKDIR /tmp/ansible-ws

EXPOSE 1-64000

RUN ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \
    cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    for key in /etc/ssh/* ; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done

CMD ["ansible-playbook", "/tmp/ansible-ws/install.yml"]
