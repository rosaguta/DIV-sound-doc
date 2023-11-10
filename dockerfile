 FROM nginx
 COPY ./exportToHTML /usr/share/nginx/html
 EXPOSE 80
 EXPOSE 443
 CMD ["nginx", "-g", "daemon off;"]
