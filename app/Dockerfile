FROM node:14-alpine AS base_stage
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install 
#&& npm prune --production && rm -rf node_modules/.cache
COPY ./ ./


FROM node:14-alpine
WORKDIR /usr/src/app

# Non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy only necessary files
COPY --from=base_stage /usr/src/app/ ./

# Change ownership to non-root user
RUN chown -R appuser:appgroup /usr/src/app

# Switch to non-root
USER appuser

EXPOSE 5000
CMD ["npm", "start"]
