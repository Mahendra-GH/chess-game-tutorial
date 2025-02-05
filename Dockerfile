FROM node:20-alpine AS build
WORKDIR /apps
COPY . /apps/
RUN npm install && npm run build && npm install --save-dev vite

FROM nginx:1.27
LABEL project="nodejs" Author="Mahendra"
RUN rm -f nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
COPY --from=build  /apps/dist/ /user/share/nginx/html/chess/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 