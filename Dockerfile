FROM node:20 AS build
RUN mkdir /apps
COPY . /apps/
RUN npm install && npm run build

FROM nginx:1-alpine-slim
LABEL project="learning"
ARG USERNAME=chess
COPY --from=build /apps/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
# Expose port 80
EXPOSE 80

# Start NGINX server
CMD ["nginx", "-g", "daemon off;"]