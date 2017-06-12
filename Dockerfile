FROM ratox-deb
USER root
RUN apt-get update && apt-get install -yq openssh-server netcat-openbsd
RUN mkdir -p /var/run/sshd
RUN useradd -ms /bin/bash ratox-ssh
USER ratox-ssh
WORKDIR /home/ratox-ssh
RUN git clone git://git.2f30.org/ratox-nuggets.git && cp ratox-nuggets/* .
RUN git clone https://github.com/cmotc/extra-ratox-nuggets.git && cp -f extra-ratox-nuggets/rat-autoapprove .
RUN sed -i 's|function ||' ./functions
RUN ratox .tox.save & sleep 10 ; echo -n "id: " && cat id && /usr/sbin/sshd -D & ./rat-autoapprove
