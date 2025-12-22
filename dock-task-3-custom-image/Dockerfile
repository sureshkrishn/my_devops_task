FROM nginx:latest

# Remove default config
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy custom index page
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
