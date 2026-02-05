FROM nginx:alpine

# Install CA certificates
RUN apk add --no-cache ca-certificates && \
    update-ca-certificates

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy custom SSL certificates if needed (optional)
# COPY ssl/ca-certificates.crt /usr/local/share/ca-certificates/
# RUN update-ca-certificates

EXPOSE 80