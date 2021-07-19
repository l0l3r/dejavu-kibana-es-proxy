FROM node:alpine
RUN apk add --no-cache git
RUN apk add --no-cache openssh
WORKDIR /data
RUN git clone --branch dev https://github.com/l0l3r/dejavu.git /dejavu
WORKDIR /dejavu
RUN git submodule init && git submodule sync && git submodule update --recursive --remote
RUN yarn
RUN yarn build:dejavu:app
RUN addgroup -S -g 201 dejavu && \
    adduser -S -u 201 -G dejavu dejavu && \
    chown -R dejavu:dejavu /dejavu

USER dejavu
EXPOSE 1358

CMD ["node", "packages/dejavu-main/server.js"]