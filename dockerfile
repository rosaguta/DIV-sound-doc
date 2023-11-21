 FROM nginx
 COPY ./exportToHTML /usr/share/nginx/html
 RUN chmod 755 /usr/share/nginx/html/images
 EXPOSE 80
 EXPOSE 443
 CMD ["nginx", "-g", "daemon off;"]
