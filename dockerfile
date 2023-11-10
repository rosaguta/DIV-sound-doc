 FROM nginx
 COPY ./exportToHTML /usr/share/nginx/html
 EXPOSE 80
 CMD ["nginx", "-g", "daemon off;"]
