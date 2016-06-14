# Ubuntu run web page processor
FROM ubuntu

MAINTAINER 0of version 1.0

RUN apt-get update && \
    apt-get install -y libgtk2.0-0 libgconf-2-4 \
    libasound2 libxtst6 libxss1 libnss3 xvfb

RUN Xvfb -ac -screen scrn 1280x960x24 :9.0 &
ENV DISPLAY :9.0

# mounted shared directory
# 	/opt/electron/electron -> electron bins
#	/opt/pagep/ -> pagep generated code
#  run command
RUN /opt/electron/electron /opt/pagep/ --load-url=$LOAD_URL

