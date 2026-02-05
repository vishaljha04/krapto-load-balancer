FROM nginx:alpine

# Install necessary packages for SSL
RUN apk add --no-cache ca-certificates && \
    update-ca-certificates

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Create health check script (optional but good practice)
RUN echo '#!/bin/sh' > /healthcheck.sh && \
    echo 'wget --quiet --tries=1 --spider http://localhost/health || exit 1' >> /healthcheck.sh && \
    chmod +x /healthcheck.sh

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]