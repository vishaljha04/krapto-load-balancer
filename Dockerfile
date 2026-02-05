FROM nginx:alpine

# remove default configs
RUN rm -rf /etc/nginx/conf.d/*

# copy our config
COPY nginx.conf /etc/nginx/nginx.conf

# expose port
EXPOSE 80

# healthcheck for Render auto restart
HEALTHCHECK CMD wget -qO- http://localhost/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
