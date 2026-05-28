FROM alpine:3.20

ARG ARCHFILL_SMOKE_VERSION=dev

LABEL org.opencontainers.image.title="archfill-smoke"
LABEL org.opencontainers.image.description="Tiny image for testing Archfill multi-arch builds."

RUN printf '%s\n' '#!/bin/sh' \
    'set -eu' \
    'printf "archfill-smoke version=%s arch=%s os=%s\n" "${ARCHFILL_SMOKE_VERSION:-dev}" "$(uname -m)" "$(uname -s)"' \
    > /usr/local/bin/archfill-smoke \
    && chmod +x /usr/local/bin/archfill-smoke

ENV ARCHFILL_SMOKE_VERSION="${ARCHFILL_SMOKE_VERSION}"

CMD ["archfill-smoke"]
