FROM nginx:alpine

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Simple health check
RUN echo '#!/bin/sh' > /healthcheck.sh && \
    echo 'wget -q -O- http://localhost/health > /dev/null 2>&1' >> /healthcheck.sh && \
    chmod +x /healthcheck.sh

EXPOSE 80