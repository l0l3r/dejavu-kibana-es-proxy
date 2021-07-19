FROM node:alpine
RUN apk add --no-cache git
RUN apk add --no-cache openssh
RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*
RUN aws --version
RUN mkdir "/root/.aws"
RUN echo "[default]" > '/root/.aws/credentials'
RUN echo "aws_access_key_id=YOUR_AWS_ACCESS_KEY" >> '/root/.aws/credentials'
RUN echo "aws_secret_access_key=YOUR_AWS_SECRET_ACCESS_KEY" >> '/root/.aws/credentials'
RUN export AWS_SHARED_CREDENTIALS_FILE=/root/.aws/credentials
RUN aws configure set region us-west-2 --profile default
WORKDIR /data
RUN git clone https://github.com/l0l3r/aws-es-kibana.git /data/app
WORKDIR /data/app
RUN npm install
EXPOSE 9200
CMD ["node", "index.js", "YOUR_AWS_URL"]
