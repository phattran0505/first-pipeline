
FROM node:18-alpine
COPY . .
RUN yarn install --production
EXPOSE 3000