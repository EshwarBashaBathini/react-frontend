# Step 1: Build React App using Node 20
FROM node:20 AS build

WORKDIR /app

# Copy dependencies and install
COPY package*.json ./
RUN npm install

# Copy source files and build
COPY . .
RUN npm run build

# Step 2: Serve the static files using 'serve'
FROM node:20-alpine

# Install the 'serve' package globally
RUN npm install -g serve

WORKDIR /app

# Copy build output from previous stage
COPY --from=build /app/build ./build

# Expose the port on which the app will run
EXPOSE 3000

# Command to run the app
CMD ["serve", "-s", "build", "-l", "3000"]
