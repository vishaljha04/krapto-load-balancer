# Use official nginx alpine image
FROM nginx:1.24-alpine

# Install envsubst for template processing
RUN apk add --no-cache gettext bash

# Copy the FULL nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Create startup script that substitutes PORT variable
RUN echo '#!/bin/sh' > /docker-entrypoint.d/90-custom.sh && \
    echo 'envsubst "\$PORT" < /etc/nginx/nginx.conf > /tmp/nginx.conf && mv /tmp/nginx.conf /etc/nginx/nginx.conf' >> /docker-entrypoint.d/90-custom.sh && \
    chmod +x /docker-entrypoint.d/90-custom.sh

# Health check script
RUN echo '#!/bin/sh' > /usr/local/bin/health-check.sh && \
    echo 'curl -f http://localhost:${PORT:-80}/health 2>/dev/null || exit 1' >> /usr/local/bin/health-check.sh && \
    chmod +x /usr/local/bin/health-check.sh

EXPOSE 80