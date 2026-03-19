FROM node:20-alpine

WORKDIR /app

# 1. Copy package files
COPY package*.json ./

# 2. Install ALL dependencies (including TypeScript)
RUN npm install

# 3. Copy source code
COPY tsconfig.json ./
COPY src ./src

# 4. Build the project (This will now find 'tsc')
RUN npm run build

# 5. (Optional but recommended) Remove devDependencies to keep image small
RUN npm prune --production

ENV NODE_ENV=production
# Ensure this matches the port you set in the YAML
EXPOSE 8080

CMD ["node", "dist/index.js"]
