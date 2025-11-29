FROM ubuntu:22.04

ARG GIT_NAME="User"
ARG GIT_EMAIL="example@example.com"

COPY src/startup-script.sh /startup-script.sh

RUN chmod +x /startup-script.sh \
    && /startup-script.sh \
    && apt clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm /startup-script.sh

CMD ["zsh"]
