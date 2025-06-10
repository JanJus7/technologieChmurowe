FROM node:20-alpine

COPY . .

RUN npm install

ENV MY_VARIABLE=my_value

EXPOSE 8080

CMD ["npm", "start"]