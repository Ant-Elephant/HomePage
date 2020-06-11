FROM node:10

RUN apt-get update && apt-get install -y nginx

WORKDIR /app
COPY package*.json ./
RUN npm install --registry=https://registry.npm.taobao.org

COPY . /app/
RUN npm run build && cp -r build/* /var/www/html && rm /etc/nginx/sites-enabled/default && cp ./ci/nginx.conf /etc/nginx/sites-enabled/ && rm -rf /app

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
