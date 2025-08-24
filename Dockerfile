FROM oven/bun:latest as build-stage
WORKDIR /app
COPY . .
RUN bun install
RUN bun run build

FROM nginx:alpine as runtime-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]