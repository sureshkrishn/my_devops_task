FROM nginx:alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy our website
COPY index.html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80
